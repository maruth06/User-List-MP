//
//  UserPageViewModel.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import UIKit
import Combine

class UserPageViewModel : ObservableObject, Identifiable {
    
    @Published private(set) var userName : String
    private var userModel : UserModel?
    
    @Published private(set) var imageUrl: String
    @Published private(set) var userFullName: String
    @Published private(set) var company : String?
    @Published private(set) var blog : String
    @Published private(set) var githubLink: String
    @Published private(set) var locationLink : String
    @Published private(set) var twitterName : String?
    @Published private(set) var userNotes : String
    
    @Published private(set) var followingCount: NSAttributedString?
    @Published private(set) var followersCount: NSAttributedString?
    
    var followersLink: String? {
        return userModel?.followersUrl
    }
    
    var followingLink: String? {
        return userModel?.followingUrl
    }
    
    var userId : Int? { return userModel?.id }
    
    init(_ userName: String) {
        self.userName = userName
        imageUrl = "n/a"
        userFullName = "n/a"
        company = "n/a"
        githubLink = "n/a"
        locationLink = "n/a"
        userNotes = "n/a"
        blog = "n/a"
    }
    
    func fetchUserDetails() {
        NetworkRequest.shared.request(type: Routes.UserPage.getUserDetails(self.userName)) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let userModel):
                self.userModel = userModel
                self.imageUrl = userModel.avatarUrl
                self.userFullName = userModel.fullName ?? "n/a"
                self.company = userModel.company ?? "n/a"
                self.blog = userModel.blog ?? "n/a"
                self.githubLink = userModel.gistsUrl
                self.locationLink = userModel.location ?? "n/a"
                self.twitterName = userModel.twitterUsername
                self.followingCount = self.buttonTitle("Following", userModel.following)
                self.followersCount = self.buttonTitle("Followers", userModel.followers)
                break
            case .failure(_): break
            }
        }
    }
    
    func requestFollowerList(_ url: String, _ completion: @escaping Completion<[User]>) {
        NetworkRequest.shared.request(type: Routes.UserPage.getFollowerList(url)) { (result) in
            switch result {
            case .success(let users):
                completion(.success(users))
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
            case .success(let users):
                completion(.success(users))
                break
            case .failure(let errorResponse):
                completion(.failure(errorResponse))
                break
            }
        }
    }
    
    private func buttonTitle(_ title: String, _ count: Int) -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSMutableAttributedString(
            string: "\(count)\n\(title)",
            attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13),
                         NSAttributedString.Key.paragraphStyle : paragraphStyle])
        return attributedString
    }
}
