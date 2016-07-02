//
//  InternetHandler.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/2/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import ReachabilitySwift

class InternetHandler: NSObject {
    
    var reachability: Reachability!
    
    // singleton instance
    class var shared: InternetHandler {
        get{
            struct StaticObject {
                static var instance: InternetHandler? = nil
                static var onceToken: dispatch_once_t = 0
            }
            
            dispatch_once(&StaticObject.onceToken) {
                StaticObject.instance = InternetHandler()
                
                do {
                    StaticObject.instance?.reachability = try Reachability.reachabilityForInternetConnection()
                    
                    do {
                        try StaticObject.instance?.reachability.startNotifier()
                    } catch {
                        print("Unable to start notifier")
                    }                    
                } catch {
                    print("Unable to create Reachability")
                    return
                }
                
            }
            return StaticObject.instance!
        }
    }
    
    func isReachable() -> Bool {
        return InternetHandler.shared.reachability.isReachable()
    }
}