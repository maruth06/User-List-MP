//
//  User_List_MPTests.swift
//  User-List-MPTests
//
//  Created by Mac Mini 2 on 9/11/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import XCTest
@testable import User_List_MP

class User_List_MPTests: XCTestCase {

    // MARK: User List
    func testFetchUserNotes() {
        XCTAssertNil(UserOfflineManager.retrieveNotes(1), "User Has Notes") // login mojombo has id 1
        UserOfflineManager.saveNotes(4, "Test notes", completion: nil)
        XCTAssertNotNil(UserOfflineManager.retrieveNotes(4)) // login wycats has id 4
    }
    
    func testSearchUser() {
        // load first source=0
        let viewModel = UserListViewModel()
        XCTAssertFalse(viewModel.performSearch(nil), "Will not perform search.")
        XCTAssertFalse(viewModel.performSearch(""), "Will not perform search.")
        XCTAssertTrue(viewModel.performSearch("wycats"), "Perform search")
        XCTAssertNil(UserOfflineManager.searchUser(""))
        XCTAssertNotNil(UserOfflineManager.searchUser("wycats"))
    }
    
    func testUserDetailsSuccessRequest() {
        let viewModel = UserPageViewModel()
        viewModel.setUserName("wycats")
        viewModel.requestUserDetails { (_) in
            XCTAssertNotNil(viewModel.userId)
        }
    }
    
    
    func testUserDetailsFailedRequest() {
        let viewModel = UserPageViewModel()
        viewModel.setUserName("")
        viewModel.requestUserDetails { (_) in
            XCTAssertNil(viewModel.userId)
        }
    }
    
    func testUserListSuccessRequest() {
        let viewModel = UserListViewModel()
        viewModel.requestUsers { (_) in
            XCTAssertTrue((viewModel.numberOfRows != 0))
        }
    }
}
