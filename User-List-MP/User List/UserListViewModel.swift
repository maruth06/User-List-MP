//
//  UserListViewModel.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import CoreData
import Combine

class UserListViewModel : ObservableObject, Identifiable {
    
    private(set) var pageNo : Int
    var pageSize : Int
    
    @Published private(set) var userList : [UserListModel] = []
    @Published private(set) var errorResponse : ErrorResponse?
    private var fetchOffset : Int
    private var loadingState : StateLoading = .finished
    
    enum StateLoading {
        case loading
        case finished
    }
    
    init() {
        pageNo = 1
        pageSize = 30
        fetchOffset = 0
    }
    
    func fetchUsers(_ loadMore: Bool=true) {
        loadingState = .loading
        NetworkRequest.shared.request(type: Routes.UserList.getUserList(pageNo)) { (result) in
            self.loadingState = .finished
                switch result {
                case .success(let userList):
                    self.pageSize = userList.count
                    if loadMore {
                        self.userList.append(contentsOf: userList)
                    } else {
                        self.userList = userList
                    }
                    self.pageNo = userList.count >= self.pageSize ? (self.pageNo + 1) : self.pageNo
                    break
                case .failure(_):
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
