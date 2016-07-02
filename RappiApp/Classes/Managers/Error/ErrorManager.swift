//
//  ErrorManager.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import UIKit

// ErrorManager Singleton class to handle Network errors

class ErrorManager: NSObject {
    
    var errorTitle:String!
    var errorMessage:String!
    var errorCode:Int!
    var cancelButtonTitle:String!
    
    /// Singleton instance
    class var shared: ErrorManager {
        get{
            struct StaticObject {
                static var instance: ErrorManager? = nil
                static var onceToken: dispatch_once_t = 0
            }
            
            dispatch_once(&StaticObject.onceToken) {
                StaticObject.instance = ErrorManager()
                StaticObject.instance?.errorCode = 0
                StaticObject.instance?.errorTitle = "Error"
                StaticObject.instance?.errorMessage = "Undefined Error"
                StaticObject.instance?.cancelButtonTitle = "OK"
            }
            return StaticObject.instance!
        }
    }
    
    class func defaultErrorMap(error: NSError) -> Void {
        
        self.shared.errorCode = error.code
        
        //map code errors as required
        switch error.code {
        case 404...499: //set all default errors
            self.shared.errorTitle = "Error, Something went wrong!"
            self.shared.errorMessage = "Sorry for the trouble! We'll take a look right away. Please try again later."
            self.shared.cancelButtonTitle = "OK"
        default:
            self.shared.errorTitle = "Error"
            self.shared.errorMessage = error.localizedDescription
            self.shared.cancelButtonTitle = "OK"
        }
        
        print("ERROR CODE: \(ErrorManager.shared.errorCode)")
        print("ERROR TITLE: \(ErrorManager.shared.errorTitle)")
        print("ERROR MESSAGE: \(ErrorManager.shared.errorMessage)")
    }
    
    class func errorAlertController(error: NSError, complete:(()->())! = nil) -> UIAlertController {
        
        //setup error correctly
        self.defaultErrorMap(error)
        
        var message:String!
        var title:String!
        
        //IMPORTANT: avoid hard-code by message, just update by error code on internalErrorMap
        title = ErrorManager.shared.errorTitle
        message = ErrorManager.shared.errorMessage
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action :UIAlertAction = UIAlertAction(title: ErrorManager.shared.cancelButtonTitle, style: .Destructive, handler: { (action: UIAlertAction!) -> Void in
            if complete != nil {
                complete()
            }
            ()
        })
        
        alert.addAction(action)
        
        return alert
    }
    
}