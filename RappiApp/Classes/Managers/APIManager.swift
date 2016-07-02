//
//  APIManager.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftyJSON
import RealmSwift
//import ObjectMapper

public class APIManager {
    
    public class var sharedInstance: APIManager {
        struct Singleton {
            static let instance : APIManager = APIManager()
        }
        return Singleton.instance
    }
    
    let manager = Manager()
    
    init() {
        
    }
    
    // MARK: apps API
    
    func GetApps(completion: (apps: [App], error: NSError?) -> ()) -> Request {
        let limit:Int = 50
        let router = AppRouter(endpoint: AppEndpoint.GetApps(limit: limit))
        
        //validate codes including those from API for custom errors
        let validStatusCodes: Range<Int> = 200...403
        return manager.request(router)
            .validate(statusCode: validStatusCodes)
            .responseJSON(completionHandler: {
                (response) -> Void in
                
                let statusCode:Int = (response.response?.statusCode)!
                
                NSLog("STATUS CODE: \(statusCode)")
                
                switch statusCode {
                case 200 ... 299:
                    NSLog("API Success")
                    
                    let jsonData = response.result.value as! JSONDictionary
                    
//                    NSLog("JSON: \(jsonData)")
                    
                    if let feed = jsonData["feed"] as? JSONDictionary,
                        let results = feed["entry"] as? [JSONDictionary] {

                        var apps:[App] = []
                        
                        NSLog("JSON: \(results)")
                        
                        //save Session Object to Realm DB
                        let realm = try! Realm()
                        do {
                            try realm.write() {
                                
                                for item in results {
                                    
                                    NSLog("ITEM: \(item)")
                                
//                                    if let app = Mapper<App>().map(item) {
//                                        realm.add(app, update: true)
//                                        
//                                        NSLog("App: \(app)")
//                                        NSLog("ID: \(app.id)")
//                                        NSLog("NAME: \(app.name)")
//                                        
//                                        apps += [app]
//                                    } else {
//                                        NSLog("WRONG MAP")
//                                    }
                                }
                                
                                completion(apps: apps, error: nil)
                                
                            }
                        } catch let error as NSError  {
                            NSLog("Error Saving to DB: \(error), \(error.userInfo)")
                            
                            completion(apps: [], error: error)
                        }
                        
                    }
                    
                default:
                    NSLog("Default failures")
                    
                    if let error = response.result.error {
                        NSLog("Error: %s", error.localizedDescription)
                        
                        //handle default error
                        completion(apps: [], error: error)
                        return
                    }
                }
            })
    }
}
