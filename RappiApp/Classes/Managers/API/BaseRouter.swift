//
//  BaseRouter.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire

//JSON and API types
public typealias JSONDictionary = [String: AnyObject]
typealias APIParams = [String : AnyObject]?

//APIConfiguration protocol
protocol APIConfiguration {
    var method: Alamofire.Method { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String? { get }
}

//BaseRouter Class based on Alamofire URLRequestConvertible and custom APIConfiguration
class BaseRouter : URLRequestConvertible, APIConfiguration {
    
    init() {}
    
    //MARK : Base Properties
    
    var method: Alamofire.Method {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var encoding: Alamofire.ParameterEncoding? {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var path: String {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var parameters: APIParams {
        fatalError("[\(NSStringFromClass(BaseRouter)) - \(#function))] Must be overridden in subclass")
    }
    
    var baseUrl: String? {
        guard let url = NSBundle.mainBundle().objectForInfoDictionaryKey("API_BASE_URL") as? String else {return nil}
        return url
    }
    
    //MARK : Base Request
    
    var URLRequest: NSMutableURLRequest {
        let baseURL = NSURL(string: baseUrl!)
        let URLRequest = NSMutableURLRequest(URL: baseURL!.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        
        if let encoding = encoding {
            return encoding.encode(URLRequest, parameters: parameters).0
        }
        
        return URLRequest
    }
}
