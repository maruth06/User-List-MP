//
//  UserModel.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/9/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation
import CoreData

//class UserModel : NSManagedObject, Codable {
//
//    @NSManaged var login : String
//    @NSManaged var id : Int
//    @NSManaged var nodeId : String
//    @NSManaged var avatarUrl : String
//    @NSManaged var gravatarId : String
//    @NSManaged var url : String
//    @NSManaged var htmlUrl : String
//    @NSManaged var followersUrl : String
//    @NSManaged var followingUrl : String
//    @NSManaged var gistsUrl : String
//    @NSManaged var starredUrl : String
//    @NSManaged var subscriptionsUrl : String
//    @NSManaged var organizationsUrl : String
//    @NSManaged var reposUrl : String
//    @NSManaged var eventsUrl : String
//    @NSManaged var receivedEventsUrl : String
//    @NSManaged var type : String
//    @NSManaged var siteAdmin : Bool
//    @NSManaged var fullName : String
//    @NSManaged var company : String?
//    @NSManaged var blog : String
//    @NSManaged var location : String
//    @NSManaged var email : String?
//    @NSManaged var hireable : String?
//    @NSManaged var bio : String?
//    @NSManaged var twitterUsername: String?
//    @NSManaged var publicRepos : Int
//    @NSManaged var publicGists : Int
//    @NSManaged var followers : Int
//    @NSManaged var following : Int
//    @NSManaged var createdAt : String
//    @NSManaged var updatedAt : String
//
//    enum CodingKeys: String, CodingKey {
//        case login, id, nodeId, avatarUrl, gravatarId, url, htmlUrl, followersUrl, followingUrl, gistsUrl, starredUrl, subscriptionsUrl, organizationsUrl, reposUrl, eventsUrl, receivedEventsUrl, type, siteAdmin, fullName = "name", company, blog, location, email, hireable, bio, twitterUsername, publicRepos, publicGists, followers, following, createdAt, updatedAt
//    }
//
//     // MARK: - Decodable
//        required convenience init(from decoder: Decoder) throws {
//            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
//                let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//                let entity = NSEntityDescription.entity(forEntityName: "UserDetailsEntity", in: managedObjectContext) else {
//                fatalError("Failed to decode User")
//            }
//
//            self.init(entity: entity, insertInto: managedObjectContext)
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            self.login = try container.decode(String.self, forKey: .login)
//            self.id = try container.decode(Int.self, forKey: .id)
//            self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
//            self.gravatarId = try container.decode(String.self, forKey: .gravatarId)
//            self.url = try container.decode(String.self, forKey: .url)
//            self.htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
//            self.followersUrl = try container.decode(String.self, forKey: .followersUrl)
//            self.followingUrl = try container.decode(String.self, forKey: .followingUrl)
//            self.gistsUrl = try container.decode(String.self, forKey: .gistsUrl)
//            self.starredUrl = try container.decode(String.self, forKey: .starredUrl)
//            self.subscriptionsUrl = try container.decode(String.self, forKey: .subscriptionsUrl)
//            self.organizationsUrl = try container.decode(String.self, forKey: .organizationsUrl)
//            self.reposUrl = try container.decode(String.self, forKey: .reposUrl)
//            self.eventsUrl = try container.decode(String.self, forKey: .eventsUrl)
//            self.receivedEventsUrl = try container.decode(String.self, forKey: .receivedEventsUrl)
//            self.type = try container.decode(String.self, forKey: .type)
//            self.siteAdmin = try container.decode(Bool.self, forKey: .siteAdmin)
//            self.fullName = try container.decode(String.self, forKey: .fullName)
//            self.company = try container.decode(String.self, forKey: .company)
//            self.blog = try container.decode(String.self, forKey: .blog)
//            self.location = try container.decode(String.self, forKey: .location)
//            self.email = try container.decodeIfPresent(String.self, forKey: .email)
//            self.hireable = try container.decodeIfPresent(String.self, forKey: .hireable)
//            self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
//            self.twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
//            self.publicRepos = try container.decode(Int.self, forKey: .publicRepos)
//            self.publicGists = try container.decode(Int.self, forKey: .publicGists)
//            self.followers = try container.decode(Int.self, forKey: .followers)
//            self.following = try container.decode(Int.self, forKey: .following)
//            self.createdAt = try container.decode(String.self, forKey: .createdAt)
//            self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
//        }
//
//        // MARK: - Encodable
//        public func encode(to encoder: Encoder) throws {
//    //        var container = encoder.container(keyedBy: CodingKeys.self)
//    //        try container.encode(avatarUrl, forKey: .avatarUrl)
//    //        try container.encode(username, forKey: .username)
//    //        try container.encode(role, forKey: .role)
//        }
//}

class UserModel : Codable {
    
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
    var fullName : String
    var company : String?
    var blog : String
    var location : String
    var email : String?
    var hireable : String?
    var bio : String?
    var twitterUsername: String?
    var publicRepos : Int
    var publicGists : Int
    var followers : Int
    var following : Int
    var createdAt : String
    var updatedAt : String
    
    enum CodingKeys: String, CodingKey {
        case login, id, nodeId, avatarUrl, gravatarId, url, htmlUrl, followersUrl, followingUrl, gistsUrl, starredUrl, subscriptionsUrl, organizationsUrl, reposUrl, eventsUrl, receivedEventsUrl, type, siteAdmin, fullName = "name", company, blog, location, email, hireable, bio, twitterUsername, publicRepos, publicGists, followers, following, createdAt, updatedAt
    }
}
