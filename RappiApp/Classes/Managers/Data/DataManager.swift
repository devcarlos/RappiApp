//
//  DataManager.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/2/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {

    static let sharedInstance = DataManager()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override init() {
        //do nothing
    }
    
    class func saveApp(app: App) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "id == %@", app.id)
        
        let fetchRequest = NSFetchRequest(entityName: "AppModel")
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [AppModel]
            
            let update = results.first
            
            NSLog("ID: \(update?.id)")
            NSLog("NAME: \(update?.name)")
            
            if results.count > 0 {
                
                //UPDATE
                self.updateApp(app)
                
            } else {
                
                //NEWAPP
                self.newApp(app)
            
            }
        } catch {
            print("Error on object update")
        }
        
        return false
    }
    
    // insert New app
    class func newApp(app: App) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        // app entity
        let entity = NSEntityDescription.entityForName("AppModel",
            inManagedObjectContext:managedContext)
        let appData = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        // generate app data
        appData.setValue(app.id, forKey: "id")
        appData.setValue(app.name, forKey: "name")
        appData.setValue(app.summary, forKey: "summary")
        appData.setValue(app.title, forKey: "title")
        appData.setValue(app.copyright, forKey: "copyright")
        appData.setValue(NSNumber(float: app.price), forKey: "price")
        appData.setValue(app.category, forKey: "category")
        appData.setValue(app.linkURL, forKey: "linkURL")
        appData.setValue(app.imageURL, forKey: "imageURL")
        appData.setValue(app.releaseDate, forKey: "releaseDate")
        
        //save app data
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    // insert New app
    class func updateApp(app: App) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "id == %@", app.id)
        
        let fetchRequest = NSFetchRequest(entityName: "AppModel")
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [AppModel]
            if results.count > 0 {
                let appData = results.first!
                appData.id = app.id
                appData.name = app.name
                appData.summary = app.summary
                appData.title = app.title
                appData.copyright = app.copyright
                appData.price = NSNumber(float: app.price)
                appData.category = app.category
                appData.linkURL = app.linkURL
                appData.imageURL = app.imageURL
                appData.releaseDate = app.releaseDate
            }
        } catch {
            print("Error on object update")
        }
        
        //update app data
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError  {
            print("Could not update \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    // delete app
    class func deleteApp(app: App) -> Bool {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "name == %@", app.name)
        
        let fetchRequest = NSFetchRequest(entityName: "AppModel")
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [AppModel]
            if results.count > 0 {
                if let AppObject = results.first {
                    managedContext.deleteObject(AppObject)
                }
            }
        } catch {
            print("Error on object delete")
        }
        
        //update app data
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    // delete app
    class func fetchAppByName(name: String) -> App? {
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "name == %@", name)
        
        let fetchRequest = NSFetchRequest(entityName: "AppModel")
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [AppModel]
            if results.count > 0 {
                if let appData = results.first {
                    let app = App()
                    
                    app.id = appData.id!
                    app.name = appData.name!
                    app.summary = appData.summary!
                    app.title = appData.title!
                    app.copyright = appData.copyright!
                    app.price = appData.price!.floatValue
                    app.category = appData.category!
                    app.linkURL = appData.linkURL!
                    app.imageURL = appData.imageURL!
                    app.releaseDate = appData.releaseDate!
                    
                    return app
                }
            }
        } catch let error as NSError  {
            print("Could not fetch app \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    class func fetchApps() -> [App] {
        
        var Apps:[App] = []
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        // fetch request
        let fetchRequest = NSFetchRequest(entityName: "AppModel")
        
        
        //save app data
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest) as! [AppModel]
            
            print(result)
            
            if result.count > 0 {
                for appData in result {
                    let app = App()
                    
                    app.id = appData.id!
                    app.name = appData.name!
                    app.summary = appData.summary!
                    app.title = appData.title!
                    app.copyright = appData.copyright!
                    app.price = appData.price!.floatValue
                    app.category = appData.category!
                    app.linkURL = appData.linkURL!
                    app.imageURL = appData.imageURL!
                    app.releaseDate = appData.releaseDate!
                    
                    Apps.append(app)
                    
                }
            }
            
            return Apps
            
        } catch let error as NSError  {
            print("Could not fetch apps \(error), \(error.userInfo)")
        }
        
        return Apps
    }
    
    // fetch apps by category
    class func fetchAppsByCategory(category: String) -> [App] {
        
        var Apps:[App] = []
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "category == %@", category)
        
        let fetchRequest = NSFetchRequest(entityName: "AppModel")
        fetchRequest.returnsDistinctResults = true
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [AppModel]
            if results.count > 0 {
                for appData in results {
                    let app = App()
                    
                    app.id = appData.id!
                    app.name = appData.name!
                    app.summary = appData.summary!
                    app.title = appData.title!
                    app.copyright = appData.copyright!
                    app.price = appData.price!.floatValue
                    app.category = appData.category!
                    app.linkURL = appData.linkURL!
                    app.imageURL = appData.imageURL!
                    app.releaseDate = appData.releaseDate!
                    
                    Apps.append(app)
                    
                }
                
                return Apps
            }
        } catch let error as NSError  {
            print("Could not fetch apps by category \(error), \(error.userInfo)")
        }
        
        return Apps
    }
    
    typealias ArrayDict = [[String:AnyObject]]
    
    // fetch apps by category
    class func fetchCategories() -> [String] {
        
        var categories:[String] = []
        var objects:[[String:AnyObject]]?
        
        let managedContext = DataManager.sharedInstance.appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("AppModel",
                                                       inManagedObjectContext:managedContext)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        fetchRequest.returnsDistinctResults = true
        fetchRequest.propertiesToFetch = ["category"]
        
        do {
            try objects = managedContext.executeFetchRequest( fetchRequest ) as? ArrayDict
            
            if let items = objects {
                NSLog("ITEMS: \(items)")
                
                for dictionary in items {
                    
                    NSLog("DICT: \(dictionary)")
                    
                    if let category = dictionary["category"] as? String {
                        categories += [category]
                    }
                }
            }
            
            return categories
        } catch let error as NSError  {
            print("Could not fetch categories \(error), \(error.userInfo)")
        }
        
        return categories
    }
    
    
}