//
//  ViewController.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit
import Network

class UserListViewController: UIViewController {
    
    private var networkIndicatorView : UIView!
    private var stackView : UIStackView!
    private var messageLabel : UILabel!
    private var userTableView : UITableView!
    
    private lazy var viewModel : UserListViewModel = {
        return UserListViewModel()
    }()
    private var coordinatorDelegate: UserListCoordinatorDelegate?
    private var activityIndicator : LoadMoreActivityIndicator!
    convenience init(_ coordinatorDelegate: UserListCoordinatorDelegate) {
        self.init()
        
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViews()
        configureViews()
        configureNetworkMonitor()
        populateListData()
    }
    
    // MARK: - UI Methods
    private func initializeViews() {
        networkIndicatorView = UIView()
        stackView = UIStackView()
        messageLabel = UILabel()
        userTableView = UITableView()
        activityIndicator = LoadMoreActivityIndicator(scrollView: userTableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
    
    private func configureViews() {
        networkIndicatorView.backgroundColor = UIColor.red
        
        messageLabel.text = "No internet connection"
        messageLabel.font = UIFont.boldSystemFont(ofSize: 12)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        let labelConstraints = [messageLabel.topAnchor.constraint(equalTo: self.networkIndicatorView.topAnchor, constant: 4),
                                messageLabel.leadingAnchor.constraint(equalTo: self.networkIndicatorView.leadingAnchor, constant: 0),
                                messageLabel.trailingAnchor.constraint(equalTo: self.networkIndicatorView.trailingAnchor, constant: 0),
                                messageLabel.bottomAnchor.constraint(equalTo: self.networkIndicatorView.bottomAnchor, constant: 4)]
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        networkIndicatorView.isHidden = false
        let viewConstraints = [stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                               stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                               stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0)]
        
        networkIndicatorView.addSubview(messageLabel)
        stackView.addArrangedSubview(networkIndicatorView)
        self.view.addSubview(stackView)
        
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.allowsMultipleSelection = false
        userTableView.allowsSelection = true
        userTableView.register(nib: UserTableViewCell.self)
        let tableViewConstraints = [userTableView.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 8),
                                    userTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                    userTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
                                    userTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0)]
        self.view.addSubview(userTableView)
        
        networkIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let finalConstraints = viewConstraints + labelConstraints + tableViewConstraints
        NSLayoutConstraint.activate(finalConstraints)
    }
    
    private func updateUINetworkIndicator(_ isHidden: Bool) {
        DispatchQueue.main.async {
            self.networkIndicatorView.isHidden = isHidden
        }
    }
    
    // MARK: - Network Methods
    private func configureNetworkMonitor() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            switch pathUpdateHandler.status {
            case .satisfied:
                print("Internet connection is on.")
                self.updateUINetworkIndicator(true)
                self.populateListData()
                break
            default:
                print("There's no internet connection.")
                self.updateUINetworkIndicator(false)
                break
            }
        }
        monitor.start(queue: queue)
    }
    
    // MARK: - Data
    private func populateListData(_ isLoadMore: Bool = false) {
        viewModel.requestUsers(isLoadMore) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.activityIndicator.stop()
                    if isLoadMore {
                        let indexPaths = self.viewModel.calculateIndexPathsToReload(from: users)
                        self.userTableView.insertRows(at: indexPaths, with: .none)
                    } else {
                        self.userTableView.reloadData()
                    }
                }
                break
            case .failure(_): break
            }
        }
    }
}

extension UserListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let model = viewModel.getUser(row: indexPath.row)
        
        cell.noteImageView.isHidden =  isNotesIconHidden(model.id)
        cell.userNameLabel.text = model.login
        cell.userDescriptionLabel.text = model.type + "\(indexPath.row)"
        cell.userProfileImageView.downloadImage(model.avatarUrl, UIImage(named: "icon-user")) {
            let modulo = indexPath.row % 3
            guard (modulo == 0 && indexPath.row != 0) else { return }
            cell.userProfileImageView.invertColor()
        }
        
        return cell
    }
    
    private func isNotesIconHidden(_ id: Int64) -> Bool {
        return UserOfflineManager.retrieveNotes(id) == nil
    }
}

extension UserListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinatorDelegate?.showUserPage(self, viewModel.getUser(row: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator.start {
            DispatchQueue.global(qos: .utility).async {
                self.populateListData(true)
            }
        }
    }
}

