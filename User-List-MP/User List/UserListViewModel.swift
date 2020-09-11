//
//  UserListViewModel.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import CoreData

class UserListViewModel {
    
    var pageNo : Int
    var pageSize : Int
    var numberOfRows : Int {
        return userList.count
    }
    
    private var userList : [UserListModel]
    private var isFetchingInProgress : Bool = false
    private var fetchOffset : Int
    
    init() {
        pageNo = 0
        userList = []
        pageSize = 30
        fetchOffset = 0
        if let users = UserOfflineManager.retrieveUserList(self.pageSize, self.fetchOffset),
            users.count > 0 {
            self.fetchOffset += users.count
            self.userList.append(contentsOf: users)
            let intId = Int(self.userList.last?.id ?? 0)
            self.pageNo = intId
        }
    }
    
    func requestUsers(_ loadMore: Bool=true, completion: @escaping Completion<[UserListModel]>) {
        guard !isFetchingInProgress else { return }
        isFetchingInProgress = true
        NetworkRequest.shared.request(type: Routes.UserList.getUserList(
            pageNo, CoreDataManager.shared.persistentContainer.viewContext)) { (result) in
                self.isFetchingInProgress = false
                switch result {
                case .success(let userList):
                    self.pageSize = userList.count
                    if loadMore {
                        self.userList.append(contentsOf: userList)
                    } else {
                        self.userList = userList
                    }
                    let intId = Int(self.userList.last?.id ?? 0)
                    self.pageNo = loadMore ? intId : 0
                    CoreDataManager.shared.saveContext(nil)
                    completion(.success(userList))
                    break
                case .failure(let errorResponse):
                    if let users = UserOfflineManager.retrieveUserList(self.pageSize, self.fetchOffset),
                    users.count > 0 {
                        if loadMore {
                            self.fetchOffset += users.count
                            self.userList.append(contentsOf: users)
                        } else {
                            self.fetchOffset = 0
                            self.userList = users
                        }
                        let intId = Int(self.userList.last?.id ?? 0)
                        self.pageNo = loadMore ? intId : 0
                    } else {
                        completion(.failure(errorResponse))
                    }
                    break
                }
        }
    }
    
    func getUser(row: Int) -> UserListModel {
        return userList[row]
    }
    
    func calculateIndexPathsToReload(from newUserList: [UserListModel]) -> [IndexPath] {
        let startIndex = userList.count - newUserList.count
        let endIndex = startIndex + newUserList.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func performSearch(_ query: String?) -> Bool {
        return (query ?? "").trimmingCharacters(in: .whitespacesAndNewlines) != ""
    }
    
    func updateUserList(users: [UserListModel]?) {
        guard let users = users else { return }
        self.userList = users
        self.pageNo = 0
    }
}
