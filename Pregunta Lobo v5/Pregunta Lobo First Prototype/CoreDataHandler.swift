//
//  CoreDataHandler.swift
//  Pregunta Lobo
//
//  Created by CAM UPRA on 4/9/18.
//  Copyright © 2018 Cheylianie Rivera. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
 
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        return appDelegate.persistentContainer.viewContext
    }
    
    
    class func saveObject(id: String, department: String, title: String, message: String, active: Bool) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Notification", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        
        manageObject.setValue(id, forKey: "id")
        manageObject.setValue(department, forKey: "department")
        manageObject.setValue(title, forKey: "title")
        manageObject.setValue(message, forKey: "message")
        manageObject.setValue(active, forKey: "active")
        
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    
    class func fetchObject() -> [Notification]? {
        let context = getContext()
        var user:[Notification]? = nil
        do {
            user = try context.fetch(Notification.fetchRequest())
            return user
        }catch {
            return user
        }
    }
    
  
    class func deleteObject(user: Notification) -> Bool {
        
        
        let context = getContext()
        context.delete(user)
        
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
        
    }
    
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Notification.fetchRequest())
        
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    
    
    class func filterData() -> [Notification]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<Notification> = Notification.fetchRequest()
        var user:[Notification]? = nil
        
        
        do {
            user = try context.fetch(fetchRequest)
            return user
            
            
        }catch {
            return user
        }
    }
}
