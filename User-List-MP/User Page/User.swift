//
//  User.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/10/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation

class User : Codable {
 
    var login : String
    var id : Int
    var nodeId : String
    var avatarUrl : String
    var gravatarId : String
    var url : String
    var htmlUrl : String
    var followersUrl : String
    var followingUrl : String
    var gistsUrl : String
    var starredUrl : String
    var subscriptionsUrl : String
    var organizationsUrl : String
    var reposUrl : String
    var eventsUrl : String
    var receivedEventsUrl : String
    var type : String
    var siteAdmin : Bool
}
