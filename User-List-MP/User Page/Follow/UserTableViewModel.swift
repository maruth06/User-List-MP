//
//  UserTableViewModel.swift
//  Users-Miho
//
//  Created by Mac on 9/10/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation

class UserTableViewModel {
    
    private var users: [User]
    var dataSource : Int {
        return users.count
    }
    
    init(_ users: [User]) {
        self.users = users
    }
    
    func getUser(row: Int) -> User {
        return users[row]
    }
}
