//
//  NotesEntity+CoreDataProperties.swift
//  User-List-MP
//
//  Created by Mac Mini 2 on 9/11/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//
//

import Foundation
import CoreData


extension NotesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesEntity> {
        return NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var message: String?

}
