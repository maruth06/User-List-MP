//
//  Routes.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import CoreData

class Routes {
    
    class UserList {
        
        static func getUserList(_ pageNo: Int) -> AppEndpoint<[UserListModel]> {
            return AppEndpoint(
                resourcePath: "users?since=\(pageNo)",
                httpMethod: .GET,
                timeout: 20)
        }
    }
    
    class UserPage {
        
        static func getUserDetails(_ userName: String) -> AppEndpoint<UserModel> {
            return AppEndpoint.init(
                resourcePath: "users/\(userName)",
                httpMethod: .GET)
        }
        
        static func getFollowerList(_ url: String) -> AppEndpoint<[User]> {
            return AppEndpoint.init(
                urlString: url,
                httpMethod: .GET,
                managedObjectContext: nil)
        }
        
        static func getFollowingList(_ userName: String) -> AppEndpoint<[User]> {
            return AppEndpoint.init(
                resourcePath: "users/\(userName)/following",
                httpMethod: .GET,
                managedObjectContext: nil)
        }
    }
}
