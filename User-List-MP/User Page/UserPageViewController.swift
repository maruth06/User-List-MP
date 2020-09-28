//
//  UserPageViewController.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit
import Network
import Combine

class UserPageViewController: UIViewController {

    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var notesTextView: UITextView!
    @IBOutlet private weak var networkIndicatorView: UIView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var blogLabel: UILabel!
    @IBOutlet private weak var githubLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var followersButton: UIButton!
    @IBOutlet private weak var saveButtonBottomConstraints: NSLayoutConstraint!
    
    private var coordinatorDelegate: UserPageCoordinatorDelegate?
    private var viewModel : UserPageViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    convenience init(_ coordinatorDelegate: UserPageCoordinatorDelegate,
                     _ viewModel: UserPageViewModel) {
        self.init()
        self.viewModel = viewModel
        self.coordinatorDelegate = coordinatorDelegate
        self.navigationItem.title = viewModel.userName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNetworkMonitor()
        setupNotificationObservers()
        configureBindings()
        viewModel.fetchUserDetails()
    }
    
    private func configureNetworkMonitor() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            switch pathUpdateHandler.status {
            case .satisfied:
                self.updateUINetworkIndicator(true)
                break
            default:
                self.updateUINetworkIndicator(false)
                break
            }
        }
        monitor.start(queue: queue)
    }
    
    private func updateUINetworkIndicator(_ isHidden: Bool) {
        DispatchQueue.main.async {
            self.networkIndicatorView.isHidden = isHidden
        }
    }
    
    private func configureBindings() {
        viewModel.$userFullName.sink { [weak self] (name) in
            self?.userNameLabel.text = name
        }.store(in: &subscriptions)
        viewModel.$imageUrl.sink { [weak self] (url) in
            self?.userImageView.downloadImage(url, UIImage(named: "icon-user"), nil)
        }.store(in: &subscriptions)
        viewModel.$company.sink { [weak self] (company) in
            self?.companyLabel.text = company
        }.store(in: &subscriptions)
        viewModel.$githubLink.sink { [weak self] (githubLink) in
            self?.githubLabel.text = githubLink
        }.store(in: &subscriptions)
        viewModel.$blog.sink { [weak self] (blog) in
            self?.blogLabel.text = blog
        }.store(in: &subscriptions)
        viewModel.$locationLink.sink { [weak self] (locationLink) in
            self?.locationLabel.text = locationLink
        }.store(in: &subscriptions)
        viewModel.$blog.sink { [weak self] (blog) in
            self?.blogLabel.text = blog
        }.store(in: &subscriptions)
        viewModel.$twitterName.sink { [weak self] (twitterName) in
            self?.twitterLabel.text = twitterName ?? nil
        }.store(in: &subscriptions)
        viewModel.$followingCount.sink { [weak self] (followingCount) in
            self?.followingButton.setAttributedTitle(followingCount, for: .normal)
        }.store(in: &subscriptions)
        viewModel.$followersCount.sink { [weak self] (followersCount) in
            self?.followersButton.setAttributedTitle(followersCount, for: .normal)
        }.store(in: &subscriptions)
    }
    
    // MARK: - Notification Observers
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    // MARK: - Action Methods
    @objc private func keyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let endFrameY = endFrame.origin.y
        let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.saveButtonBottomConstraints.constant = 16
        } else {
            self.saveButtonBottomConstraints.constant = (endFrame.size.height - view.safeAreaInsets.bottom) + 8
        }
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { if let view = self.view { view.layoutIfNeeded() } },
                       completion: nil)
    }
    
    @IBAction func onTappedButtonFollowers(_ sender: Any) {
        guard let urlString = viewModel.followersLink,
            let _ = URL(string: urlString) else {
            self.showAlertDialog("Error", "Invalid url")
            return
        }
        viewModel.requestFollowerList(urlString) { (result) in
            switch result {
            case .success(let users):
                self.coordinatorDelegate?.showUserFollowers(self, users)
                break
            case .failure(let error):
                self.showAlertDialog("Error", error.localizedDescription)
                break
            }
        }
    }
    
    @IBAction func onTappedButtonFollowing(_ sender: Any) {
        viewModel.requestFollowingList { (result) in
            switch result {
            case .success(let users):
                self.coordinatorDelegate?.showUserFollowing(self, users)
                break
            case .failure(let error):
                self.showAlertDialog("Error", error.localizedDescription)
                break
            }
        }
    }
    
    @IBAction func onTappedSaveButton(_ sender: Any) {
//        guard let userId = viewModel.userId else { return }
//        UserOfflineManager.saveNotes(userId, notesTextView.text) { (error) in
//            if let error = error {
//                self.showAlertDialog("Error", error.localizedDescription, buttonTitle: "OK")
//            }
//        }
    }
}
