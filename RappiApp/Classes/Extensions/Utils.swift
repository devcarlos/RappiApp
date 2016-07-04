//
//  NSBundleExtensions.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import Foundation

extension String {
    var URLEncoded:String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = NSCharacterSet(charactersInString: unreservedChars)
        let encodedString = self.stringByAddingPercentEncodingWithAllowedCharacters(unreservedCharset)
        return encodedString ?? self
    }
}
// to display an alert message ViewControllers
extension UIViewController {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Destructive, handler: handler)
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showConfirmAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Destructive, handler: handler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}