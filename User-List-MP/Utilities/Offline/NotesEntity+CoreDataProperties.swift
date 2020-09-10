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


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var id: Int64
    @NSManaged public var message: String?

}
