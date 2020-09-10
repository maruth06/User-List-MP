//
//  UserListModel.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import CoreData

@objc(UserListModel)
class UserListModel : NSManagedObject, Codable {

    @NSManaged var login : String
    @NSManaged var id : Int64
    @NSManaged var nodeId : String
    @NSManaged var avatarUrl : String
    @NSManaged var gravatarId : String
    @NSManaged var url : String
    @NSManaged var htmlUrl : String
    @NSManaged var followersUrl : String
    @NSManaged var followingUrl : String
    @NSManaged var gistsUrl : String
    @NSManaged var starredUrl : String
    @NSManaged var subscriptionsUrl : String
    @NSManaged var organizationsUrl : String
    @NSManaged var reposUrl : String
    @NSManaged var eventsUrl : String
    @NSManaged var receivedEventsUrl : String
    @NSManaged var type : String
    @NSManaged var siteAdmin : Bool

    enum CodingKeys: String, CodingKey {
        case login, id, nodeId, avatarUrl, gravatarId, url, htmlUrl, followersUrl, followingUrl, gistsUrl, starredUrl, subscriptionsUrl, organizationsUrl, reposUrl, eventsUrl, receivedEventsUrl, type, siteAdmin
    }

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "UserListModel", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.login = try container.decode(String.self, forKey: .login)
        self.id = try container.decode(Int64.self, forKey: .id)
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
    }
}
