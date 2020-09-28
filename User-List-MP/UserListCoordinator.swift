//
//  UserListCoordinator.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import UIKit

protocol UserListCoordinatorDelegate {
    func showUserPage(_ userListViewController: UserListViewController, _ userListModel: UserListModel)
}

protocol UserPageCoordinatorDelegate {
    func showUserFollowers(_ userPageViewController: UserPageViewController, _ users: [User])
    func showUserFollowing(_ userPageViewController: UserPageViewController, _ users: [User])
}

class UserListCoordinator : Coordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = UserListViewController(self, UserListViewModel())
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension UserListCoordinator : UserListCoordinatorDelegate {
    func showUserPage(_ userListViewController: UserListViewController, _ userListModel: UserListModel) {
        let userPageViewController = UserPageViewController(self, userListModel.login)
        userListViewController.navigationController?.pushViewController(userPageViewController, animated: true)
    }
}

extension UserListCoordinator : UserPageCoordinatorDelegate {
    
    func showUserFollowers(_ userPageViewController: UserPageViewController, _ users: [User]) {
        
        let tableViewController = UserTableViewController(users)
        let navigationController = UINavigationController(rootViewController: tableViewController)
        userPageViewController.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func showUserFollowing(_ userPageViewController: UserPageViewController, _ users: [User]) {
        let tableViewController = UserTableViewController(users)
        let navigationController = UINavigationController(rootViewController: tableViewController)
        userPageViewController.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
