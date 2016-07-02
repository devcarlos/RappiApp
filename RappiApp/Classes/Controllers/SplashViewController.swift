//
//  SplashViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import Alamofire
import ReachabilitySwift


class SplashViewController: UIViewController, UITextFieldDelegate {
    
    //MARK : IBOutlets
    
    
    
    //MARK : Properties
    
    var request: Request?
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //load the API data everytime we get to this screen
        self.loadData()
    }
    
    deinit {
        self.request?.cancel()
    }
    
    
    //MARK : API Call Functions
    
    func loadData() {
        
        //Internet ONLINE then we callback the API load
        if InternetHandler.shared.isReachable() {
            
            //TODO: show ONLINE
            
            NSLog("ONLINE")
            
            //callback to load API data and save to Realm DB
            self.request = APIManager.sharedInstance.GetApps { [unowned self]
                (apps, error) in
                
                self.request = nil
                
                if let errorValid = error {
                    let alert = ErrorManager.errorAlertController(errorValid)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    
                    print("APPS: \(apps.count)")
                    
                    //iterate and display apps on map
                    for app in apps {
                        print("ID: \(app.id)")
                        print("NAME: \(app.name)")
                    }
                }
            }
        } else {
            //TODO: show OFFLINE
            
            NSLog("OFFLINE")
        
        }
    }
        
    //MARK : Actions
    
}
