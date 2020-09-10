//
//  UserOfflineManager.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import CoreData

class UserOfflineManager {
    
    
    static func fetchUserDetails() {
        //        let fetchRequest = NSFetchRequest<UserModel>(entityName: "UserDetailsEntity")
        //        let sort = NSSortDescriptor(key: "gitcommit.committer.date", ascending: false)
        //        fetchRequest.sortDescriptors = [sort]
        //        do {
        //            // fetch is performed on the NSManagedObjectContext
        //            let data = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
        //            print("Got \(data.count) commits")
        //        } catch {
        //            print("Fetch failed")
        //        }
    }
    
    static func saveNotes(_ id: Int, _ message: String, completion: ((_ error: NSError?)->Void)?) {
        guard let entity = NSEntityDescription.entity(
            forEntityName: "NotesEntity",
            in: CoreDataManager.shared.persistentContainer.viewContext) else { return }
        let fetchRequest = NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let notes = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            if let note = notes.first {
                note.setValue(message, forKey: "message")
            } else {
                let note = NSManagedObject(entity: entity,
                                           insertInto: CoreDataManager.shared.persistentContainer.viewContext)
                note.setValue(id, forKey: "id")
                note.setValue(message, forKey: "message")
            }
            CoreDataManager.shared.saveContext(completion)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func retrieveNotes(_ id: Int) -> String? {
        let id64 = Int64(id)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id64)
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes.first?.message
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    static func searchUser(_ query: String) {
        
    }
}
