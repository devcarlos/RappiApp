//
//  Category.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import Foundation
//import ObjectMapper
import RealmSwift
import Realm

private let ID_KEY = "attributes.im:id"
private let CNAME_KEY = "attributes.term"

//Session Model Class
public class Category: Object {//, Mappable {
    
    //MARK : Properties
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    
//    let apps = LinkingObjects(fromType: App.self, property: "category")
    
    override public static func primaryKey() -> String? {
        return "id"
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
//        id <- map[ID_KEY]
//        name <- map[CNAME_KEY]
//    }
    
    //MARK : Realm initializers
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
    
}
