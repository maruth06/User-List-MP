//
//  UserModel.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import CoreData

//@objc(UserModel)
//class UserModel : NSManagedObject, Codable {
//
//    @NSManaged var login : String
//    @NSManaged var id : Int64
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
//    @NSManaged var publicRepos : Int64
//    @NSManaged var publicGists : Int64
//    @NSManaged var followers : Int64
//    @NSManaged var following : Int64
//    @NSManaged var createdAt : String
//    @NSManaged var updatedAt : String
//
//    enum CodingKeys: String, CodingKey {
//        case login, id, nodeId, avatarUrl, gravatarId, url, htmlUrl, followersUrl, followingUrl, gistsUrl, starredUrl, subscriptionsUrl, organizationsUrl, reposUrl, eventsUrl, receivedEventsUrl, type, siteAdmin, fullName = "name", company, blog, location, email, hireable, bio, twitterUsername, publicRepos, publicGists, followers, following, createdAt, updatedAt
//    }
//
//    // MARK: - Decodable
//    required convenience init(from decoder: Decoder) throws {
//        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
//            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//            let entity = NSEntityDescription.entity(forEntityName: "UserModel", in: managedObjectContext) else {
//                fatalError("Failed to decode User")
//        }
//
//        self.init(entity: entity, insertInto: managedObjectContext)
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.login = try container.decode(String.self, forKey: .login)
//        self.id = try container.decode(Int64.self, forKey: .id)
//        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
//        self.gravatarId = try container.decode(String.self, forKey: .gravatarId)
//        self.url = try container.decode(String.self, forKey: .url)
//        self.htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
//        self.followersUrl = try container.decode(String.self, forKey: .followersUrl)
//        self.followingUrl = try container.decode(String.self, forKey: .followingUrl)
//        self.gistsUrl = try container.decode(String.self, forKey: .gistsUrl)
//        self.starredUrl = try container.decode(String.self, forKey: .starredUrl)
//        self.subscriptionsUrl = try container.decode(String.self, forKey: .subscriptionsUrl)
//        self.organizationsUrl = try container.decode(String.self, forKey: .organizationsUrl)
//        self.reposUrl = try container.decode(String.self, forKey: .reposUrl)
//        self.eventsUrl = try container.decode(String.self, forKey: .eventsUrl)
//        self.receivedEventsUrl = try container.decode(String.self, forKey: .receivedEventsUrl)
//        self.type = try container.decode(String.self, forKey: .type)
//        self.siteAdmin = try container.decode(Bool.self, forKey: .siteAdmin)
//        self.fullName = try container.decode(String.self, forKey: .fullName)
//        self.company = try container.decode(String.self, forKey: .company)
//        self.blog = try container.decode(String.self, forKey: .blog)
//        self.location = try container.decode(String.self, forKey: .location)
//        self.email = try container.decodeIfPresent(String.self, forKey: .email)
//        self.hireable = try container.decodeIfPresent(String.self, forKey: .hireable)
//        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
//        self.twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
//        self.publicRepos = try container.decode(Int64.self, forKey: .publicRepos)
//        self.publicGists = try container.decode(Int64.self, forKey: .publicGists)
//        self.followers = try container.decode(Int64.self, forKey: .followers)
//        self.following = try container.decode(Int64.self, forKey: .following)
//        self.createdAt = try container.decode(String.self, forKey: .createdAt)
//        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
//    }
//
//    // MARK: - Encodable
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(login, forKey: .login)
//        try container.encode(id, forKey: .id)
//        try container.encode(avatarUrl, forKey: .avatarUrl)
//        try container.encode(gravatarId, forKey: .gravatarId)
//        try container.encode(url, forKey: .url)
//        try container.encode(htmlUrl, forKey: .htmlUrl)
//        try container.encode(followersUrl, forKey: .followersUrl)
//        try container.encode(followingUrl, forKey: .followingUrl)
//        try container.encode(gistsUrl, forKey: .gistsUrl)
//        try container.encode(starredUrl, forKey: .starredUrl)
//        try container.encode(subscriptionsUrl, forKey: .subscriptionsUrl)
//        try container.encode(organizationsUrl, forKey: .organizationsUrl)
//        try container.encode(reposUrl, forKey: .reposUrl)
//        try container.encode(eventsUrl, forKey: .eventsUrl)
//        try container.encode(receivedEventsUrl, forKey: .receivedEventsUrl)
//        try container.encode(type, forKey: .type)
//        try container.encode(siteAdmin, forKey: .siteAdmin)
//        try container.encode(fullName, forKey: .fullName)
//        try container.encode(company, forKey: .company)
//        try container.encode(blog, forKey: .blog)
//        try container.encode(location, forKey: .location)
//        try container.encode(email, forKey: .email)
//        try container.encode(hireable, forKey: .hireable)
//        try container.encode(bio, forKey: .bio)
//        try container.encode(twitterUsername, forKey: .twitterUsername)
//        try container.encode(publicRepos, forKey: .publicRepos)
//        try container.encode(publicGists, forKey: .publicGists)
//        try container.encode(followers, forKey: .followers)
//        try container.encode(following, forKey: .following)
//        try container.encode(createdAt, forKey: .createdAt)
//        try container.encode(updatedAt, forKey: .updatedAt)
//    }
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
    var fullName : String?
    var company : String?
    var blog : String?
    var location : String?
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
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nodeId = try container.decode(String.self, forKey: .nodeId)
        self.login = try container.decode(String.self, forKey: .login)
        self.id = try container.decode(Int.self, forKey: .id)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.gravatarId = try container.decode(String.self, forKey: .gravatarId)
        self.url = try container.decode(String.self, forKey: .url)
        self.htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        self.followersUrl = try container.decode(String.self, forKey: .followersUrl)
        self.followingUrl = try container.decode(String.self, forKey: .followingUrl)
        self.gistsUrl = try container.decode(String.self, forKey: .gistsUrl)
        self.starredUrl = try container.decode(String.self, forKey: .starredUrl)
        self.subscriptionsUrl = try container.decode(String.self, forKey: .subscriptionsUrl)
        self.organizationsUrl = try container.decode(String.self, forKey: .organizationsUrl)
        self.reposUrl = try container.decode(String.self, forKey: .reposUrl)
        self.eventsUrl = try container.decode(String.self, forKey: .eventsUrl)
        self.receivedEventsUrl = try container.decode(String.self, forKey: .receivedEventsUrl)
        self.type = try container.decode(String.self, forKey: .type)
        self.siteAdmin = try container.decode(Bool.self, forKey: .siteAdmin)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.blog = try container.decodeIfPresent(String.self, forKey: .blog)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.hireable = try container.decodeIfPresent(String.self, forKey: .hireable)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
        self.publicRepos = try container.decode(Int.self, forKey: .publicRepos)
        self.publicGists = try container.decode(Int.self, forKey: .publicGists)
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.following = try container.decode(Int.self, forKey: .following)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(login, forKey: .login)
        try container.encode(id, forKey: .id)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(gravatarId, forKey: .gravatarId)
        try container.encode(url, forKey: .url)
        try container.encode(htmlUrl, forKey: .htmlUrl)
        try container.encode(followersUrl, forKey: .followersUrl)
        try container.encode(followingUrl, forKey: .followingUrl)
        try container.encode(gistsUrl, forKey: .gistsUrl)
        try container.encode(starredUrl, forKey: .starredUrl)
        try container.encode(subscriptionsUrl, forKey: .subscriptionsUrl)
        try container.encode(organizationsUrl, forKey: .organizationsUrl)
        try container.encode(reposUrl, forKey: .reposUrl)
        try container.encode(eventsUrl, forKey: .eventsUrl)
        try container.encode(receivedEventsUrl, forKey: .receivedEventsUrl)
        try container.encode(type, forKey: .type)
        try container.encode(siteAdmin, forKey: .siteAdmin)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(company, forKey: .company)
        try container.encode(blog, forKey: .blog)
        try container.encode(location, forKey: .location)
        try container.encode(email, forKey: .email)
        try container.encode(hireable, forKey: .hireable)
        try container.encode(bio, forKey: .bio)
        try container.encode(twitterUsername, forKey: .twitterUsername)
        try container.encode(publicRepos, forKey: .publicRepos)
        try container.encode(publicGists, forKey: .publicGists)
        try container.encode(followers, forKey: .followers)
        try container.encode(following, forKey: .following)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}
