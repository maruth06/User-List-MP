//
//  UserPageViewController.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/9/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import UIKit
import Network

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
    private var viewModel : UserPageViewModel = {
        return UserPageViewModel()
    }()
    
    convenience init(_ coordinatorDelegate: UserPageCoordinatorDelegate,
                     _ userName: String) {
        self.init()
        
        self.coordinatorDelegate = coordinatorDelegate
        self.viewModel.setUserName(userName)
        self.navigationItem.title = userName
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNetworkMonitor()
        populateData()
        setupNotificationObservers()
    }
    
    private func configureNetworkMonitor() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            switch pathUpdateHandler.status {
            case .satisfied:
                print("Internet connection is on.")
                self.updateUINetworkIndicator(true)
                self.populateData()
                break
            default:
                print("There's no internet connection.")
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
    
    private func updateUI() {
        userNameLabel.text = viewModel.userFullName
        userImageView.downloadImage(viewModel.imageUrl, UIImage(named: "icon-user"), nil)
        companyLabel.text = viewModel.company
        githubLabel.text = viewModel.githubLink
        blogLabel.text = viewModel.blog
        locationLabel.text = viewModel.locationLink
        twitterLabel.text = viewModel.twitterName
        followingButton.setAttributedTitle(viewModel.followingCount, for: .normal)
        followersButton.setAttributedTitle(viewModel.followersCount, for: .normal)
    }
    
    // MARK: - Data
    private func populateData() {
        viewModel.requestUserDetails { (_) in
            self.updateUI()
        }
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
        
    }
}
