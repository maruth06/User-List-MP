//
//  AppEndPoint.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/8/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation
import CoreData

struct AppEndpoint<T> {
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders?
    var timeout: TimeInterval = 20
    var httpBody: Data?
    
    var url: URL
    var managedObjectContext: NSManagedObjectContext?
    var resourcePath : String = ""
    
    init(resourcePath: String,
         httpMethod: HTTPMethod,
         timeout: TimeInterval = 20,
         managedObjectContext: NSManagedObjectContext? = nil) {
        self.resourcePath = resourcePath
        self.url = URL(string: "https://api.github.com/" + resourcePath)!
        self.httpMethod = httpMethod
        self.timeout = timeout
        self.managedObjectContext = managedObjectContext
    }
    
    init(urlString: String,
         httpMethod: HTTPMethod,
         timeout: TimeInterval = 20,
         managedObjectContext: NSManagedObjectContext? = nil) {
        self.url = URL(string: urlString)!
        self.httpMethod = httpMethod
        self.timeout = timeout
        self.managedObjectContext = managedObjectContext
    }
}
