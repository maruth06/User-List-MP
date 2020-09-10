//
//  UserListViewModel.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation

class UserListViewModel {
    
    var pageNo : Int
    var itemCountPerPage : Int
    var numberOfRows : Int {
        return userList.count
    }
    
    private var userList : [UserListModel]
    private var isFetchingInProgress : Bool = false
    
    init() {
        pageNo = 0
        userList = []
        itemCountPerPage = 30
    }
    
    func requestUsers(_ loadMore: Bool=true, completion: @escaping Completion<[UserListModel]>) {
        guard !isFetchingInProgress else { return }
        isFetchingInProgress = true
        NetworkRequest.shared.request(type: Routes.UserList.getUserList(
            pageNo, CoreDataManager.shared.persistentContainer.viewContext)) { (result) in
                self.isFetchingInProgress = false
                switch result {
                case .success(let userList):
                    self.itemCountPerPage = userList.count
                    if loadMore {
                        self.userList.append(contentsOf: userList)
                    } else {
                        self.userList = userList
                    }
                    self.pageNo = loadMore
                        ? (self.userList.last?.userId ?? self.pageNo + 1)
                        : 0
                    completion(.success(userList))
                    break
                case .failure(let errorResponse):
                    completion(.failure(errorResponse))
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
}
