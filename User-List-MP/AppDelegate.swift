//
//  AppDelegate.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/8/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userListCoordinator : UserListCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        userListCoordinator = UserListCoordinator(window: window)
        userListCoordinator.start()
        return true
    }
}

