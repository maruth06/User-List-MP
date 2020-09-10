//
//  CodingUserInfoKey+Extensions.swift
//  Users-Miho
//
//  Created by Mac on 9/10/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation


extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
