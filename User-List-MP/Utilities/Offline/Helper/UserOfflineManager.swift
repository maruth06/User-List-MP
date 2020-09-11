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
    
    static func retrieveUserList(_ pageSize: Int, _ offset: Int) -> [UserListModel]? {
        let fetchRequest = NSFetchRequest<UserListModel>(entityName: "UserListModel")
        fetchRequest.fetchBatchSize = pageSize
        fetchRequest.fetchOffset = offset
        do {
           let users = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            return users
        } catch _ as NSError {
            return nil
        }
    }
    
    static func retrieveUserDetails(_ userName: String) -> UserModel? {
        let fetchRequest = NSFetchRequest<UserModel>(entityName: "UserModel")
        fetchRequest.predicate = NSPredicate(format: "login = %@", userName)
        do {
           let users = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            return users.first
        } catch _ as NSError {
            return nil
        }
    }
    
    static func saveNotes(_ id: Int64, _ message: String, completion: ((_ error: NSError?)->Void)?) {
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Notes",
            in: CoreDataManager.shared.persistentContainer.viewContext) else { return }
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
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
    
    static func retrieveNotes(_ id: Int64) -> String? {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes.first?.message
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    static func searchUser(_ query: String) -> [UserListModel]? {
        let fetchRequest = NSFetchRequest<UserListModel>(entityName: "UserListModel")
        fetchRequest.predicate = NSPredicate(format: "login CONTAINS[cd] %@", query)
        do {
           let users = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            return users.count == 0 ? nil : users
        } catch _ as NSError {
            return nil
        }
    }
}
