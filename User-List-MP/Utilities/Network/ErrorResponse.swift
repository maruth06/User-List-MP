//
//  ErrorResponse.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/8/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation

import Foundation

class NetworkError : Codable {
    
    var message: String?
    var documentationUrl: String?
}

class ErrorResponse : Error {
    var statusCode: Int?

    init(_ networkError : NetworkError?=nil,
         _ statusCode : Int?=nil) {
        
        self.statusCode = statusCode
    }
    
    init(_ statusCode: Int) {
        self.statusCode = statusCode
    }
    
    init(_ error: Error) {
//        se = error
    }
}
