//
//  Routes.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/9/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation
import CoreData

class Routes {
    
    class UserList {
        
        static func getUserList(_ pageNo: Int, _ managedObjectContext: NSManagedObjectContext?) -> AppEndpoint<[UserListModel]> {
            return AppEndpoint(
                resourcePath: "users?since=\(pageNo)",
                httpMethod: .GET,
                timeout: 20,
                managedObjectContext: managedObjectContext)
        }
    }
    
    class UserPage {
        
        static func getUserDetails(_ userName: String,
                                   _ managedObjectContext: NSManagedObjectContext?) -> AppEndpoint<UserModel> {
            return AppEndpoint.init(
                resourcePath: "users/\(userName)",
                httpMethod: .GET,
                managedObjectContext: managedObjectContext)
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