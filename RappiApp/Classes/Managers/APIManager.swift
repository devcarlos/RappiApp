//
//  APIManager.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

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
        let limit:Int = 20
        let router = AppRouter(endpoint: AppEndpoint.GetApps(limit: limit))
        
        //validate codes including those from API for custom errors
        return manager.request(router)
            .validate()
            .responseJSON(completionHandler: {
                (response) -> Void in
                
                NSLog("API Success")
                
                let jsonData = response.result.value as! JSONDictionary
                
                if let feed = jsonData["feed"] as? JSONDictionary,
                    let results = feed["entry"] as? [JSONDictionary] {

                    var apps:[App] = []
                    
                    //map objects
                    for item in results {
                        if let app = Mapper<App>().map(item) {
                            
                            if DataManager.saveApp(app) {
                                
//                                NSLog("App: \(app)")
//                                NSLog("ID: \(app.id)")
//                                NSLog("NAME: \(app.name)")
//                                NSLog("SUMMARY: \(app.summary)")
//                                NSLog("PRICE: \(app.price)")
//                                NSLog("TITLE: \(app.title)")
//                                NSLog("COPY: \(app.copyright)")
//                                NSLog("CATEGORY: \(app.category)")
//                                NSLog("IMAGE: \(app.imageURL)")
//                                NSLog("LINK: \(app.linkURL)")
//                                NSLog("DATE: \(app.releaseDate)")
                                apps += [app]
                            }
                        } else {
                            NSLog("Error on Map Object")
                        }
                    }
                    
                    completion(apps: apps, error: nil)
                    
                }

            })
    }
}
