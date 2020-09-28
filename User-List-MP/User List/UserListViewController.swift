//
//  ViewController.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit
import Network
import Combine

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkView: UIView!
    
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: UserListViewModel!
    private var coordinatorDelegate: UserListCoordinatorDelegate?
    private var activityIndicator : LoadMoreActivityIndicator!
    
    convenience init(_ coordinatorDelegate: UserListCoordinatorDelegate,
                     _ viewModel: UserListViewModel) {
        self.init()
        self.viewModel = viewModel
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureNetworkMonitor()
        configureBindings()
        viewModel.fetchUsers()
    }
    
    // MARK: - UI Methods
    
    private func configureViews() {
        activityIndicator = LoadMoreActivityIndicator(scrollView: tableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
        tableView.register(nib: UserTableViewCell.self)
        tableView.reloadData()
    }
    
    private func configureBindings() {
        viewModel.$userList.compactMap { (userList) -> [UserListModel]? in
            return userList
        }.sink { (userList) in
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    private func updateUINetworkIndicator(_ isHidden: Bool) {
        DispatchQueue.main.async {
            self.networkView.isHidden = isHidden
        }
    }
    
    // MARK: - Network Methods
    private func configureNetworkMonitor() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            switch pathUpdateHandler.status {
            case .satisfied:
                self.updateUINetworkIndicator(true)
                self.viewModel.fetchUsers()
                break
            case .requiresConnection:
                break
            case .unsatisfied:
                break
            default:
                self.updateUINetworkIndicator(false)
                break
            }
        }
        monitor.start(queue: queue)
    }
}

extension UserListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let model = viewModel.getUser(row: indexPath.row)
        
        cell.noteImageView.isHidden = true // isNotesIconHidden(model.id)
        cell.userNameLabel.text = model.login
        cell.userDescriptionLabel.text = model.type + "\(indexPath.row)"
        cell.userProfileImageView.downloadImage(model.avatarUrl, UIImage(named: "icon-user")) {
            let modulo = indexPath.row % 3
            guard (modulo == 0 && indexPath.row != 0) else { return }
            cell.userProfileImageView.invertColor()
        }
        
        return cell
    }
    
//    private func isNotesIconHidden(_ id: Int) -> Bool {
//        return UserOfflineManager.retrieveNotes(id) == nil
//    }
}

extension UserListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinatorDelegate?.showUserPage(self, viewModel.getUser(row: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator.start {
            DispatchQueue.global(qos: .utility).async {
                self.viewModel.fetchUsers(true)
            }
        }
    }
}
