//
//  UserPageViewModel.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/9/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation
import UIKit

class UserPageViewModel {
    
    private var userName : String
    private var userModel : UserModel?
    
    var imageUrl: String { return userModel?.avatarUrl ?? "" }
    var userFullName: String { return userModel?.fullName ?? "n/a" }
    var company : String { return userModel?.company ?? "n/a"}
    var blog : String { return userModel?.blog ?? "n/a" }
    var githubLink: String { return userModel?.htmlUrl ?? "n/a" }
    var locationLink : String { return userModel?.location ?? "n/a"}
    var twitterName : String { return userModel?.twitterUsername ?? "n/a"}
    
    var followingCount: NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSMutableAttributedString(
            string: "\(userModel?.following ?? 0)\nFollowing",
            attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13),
                         NSAttributedString.Key.paragraphStyle : paragraphStyle])
        return attributedString // "\(userModel?.following ?? 0)\nFollowing"
    }
    var followersCount: NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSMutableAttributedString(
            string: "\(userModel?.followers ?? 0)\nFollowers",
            attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13),
                         NSAttributedString.Key.paragraphStyle : paragraphStyle])
        return attributedString // "\(userModel?.followers ?? 0)\nFollowers"
    }
    var followersLink: String? {
        return userModel?.followersUrl
    }
    var followingLink: String? {
        return userModel?.followingUrl
    }
    
    init() {
        self.userName = ""
    }
    
    func setUserName(_ userName: String) {
        self.userName = userName
    }
    
    func requestUserDetails(completion: @escaping Completion<UserModel>) {
        NetworkRequest.shared.request(type: Routes.UserPage.getUserDetails(
            self.userName, CoreDataManager.shared.persistentContainer.viewContext)) { (result) in
            switch result {
            case .success(let userModel):
                self.userModel = userModel
                CoreDataManager.shared.saveContext(nil)
                completion(.success(userModel))
                break
            case .failure(let errorResponse):
                completion(.failure(errorResponse))
                break
            }
        }
    }
    
    func requestFollowerList(_ url: String, _ completion: @escaping Completion<[User]>) {
        NetworkRequest.shared.request(type: Routes.UserPage.getFollowerList(url)) { (result) in
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
                break
            case .failure(let errorResponse):
                completion(.failure(errorResponse))
                break
            }
        }
    }
    
    func requestFollowingList( _ completion: @escaping Completion<[User]>) {
           NetworkRequest.shared.request(type: Routes.UserPage.getFollowingList(userName)) { (result) in
               switch result {
               case .success(let userModel):
                   completion(.success(userModel))
                   break
               case .failure(let errorResponse):
                   completion(.failure(errorResponse))
                   break
               }
           }
       }
}