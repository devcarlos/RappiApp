//
//  Image.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/2/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
//import ObjectMapper
import RealmSwift
import Realm

private let URL_KEY = "label"
private let HEIGHT_KEY = "attributes.height"

//Session Model Class
public class Image: Object {//, Mappable {
    
    //MARK : Properties
    
    
    dynamic var url: String = ""
    dynamic var height: Float = 0
    
    override public static func primaryKey() -> String? {
        return "url"
    }
    
    //MARK : init functions
    
    required public init() {
        super.init()
    }
    
//    required convenience public init?(_ map: Map) {
//        self.init()
//    }
//    
//    //MARK : Mapping
//    
//    public func mapping(map: Map) {
//        url <- map[URL_KEY]
//        height <- map[HEIGHT_KEY]
//    }
    
    //MARK : Realm initializers
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
    
}
