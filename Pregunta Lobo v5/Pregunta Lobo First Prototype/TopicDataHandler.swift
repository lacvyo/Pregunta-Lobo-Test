//
//  CoreDataHandler.swift
//  Pregunta Lobo
//
//  Created by CAM UPRA on 4/9/18.
//  Copyright © 2018 Cheylianie Rivera. All rights reserved.
//
import UIKit
import CoreData

class TopicDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        return appDelegate.persistentContainer.viewContext
    }
    
    
    class func saveObject(topic: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Topics", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        
        manageObject.setValue(topic, forKey: "topic")
        
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    
    class func fetchObject() -> [Topics]? {
        let context = getContext()
        var user:[Topics]? = nil
        do {
            user = try context.fetch(Topics.fetchRequest())
            return user
        }catch {
            return user
        }
    }
    
    
    class func deleteObject(topic: Topics) -> Bool {
        
        let context = getContext()
        context.delete(topic)
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
        
    }
    
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Topics.fetchRequest())
        
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    
    
    class func filterData() -> [Topics]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<Topics> = Topics.fetchRequest()
        var user:[Topics]? = nil
        
        
        do {
            user = try context.fetch(fetchRequest)
            return user
            
            
        }catch {
            return user
        }
    }
}

