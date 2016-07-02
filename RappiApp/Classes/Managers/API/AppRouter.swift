//
//  PlaceRouter.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
import Alamofire

enum AppEndpoint {
    case GetApps(limit: Int)
}

class AppRouter : BaseRouter {
    
    var endpoint: AppEndpoint
        
    init(endpoint: AppEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: Alamofire.Method {
        switch endpoint {
        case .GetApps: return .GET
        }
    }
    
    override var path: String {
        switch endpoint {
            //we can make this URL more dynamic sending parameters
            case .GetApps(let limit):
                let path = "limit=\(limit)/json"
                return path
        }
    }
    
    override var parameters: APIParams {
        switch endpoint {
        case .GetApps(let limit):
            NSLog("LIMIT \(limit)")
            return [:]
        }
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        switch endpoint {
        case .GetApps: return .URL
        }
    }
    
}
