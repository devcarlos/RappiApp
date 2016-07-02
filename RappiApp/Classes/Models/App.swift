//
//  Place.swift
//  RappiApp
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//


import Foundation
//import ObjectMapper
import RealmSwift
import Realm


private let ID_KEY = "id.attributes.im:id"
private let NAME_KEY = "im:name.label"
private let SUM_KEY = "summary"
private let COPY_KEY = "rights.label"
private let PRICE_KEY = "im:price"
private let AMOUNT_KEY = "attributes.amount"
private let CURR_KEY = "attributes.currency"
private let TITLE_KEY = "title.label"
private let IMAGE_KEY = "im:image"
private let LINK_KEY = "link"
private let DATE_KEY = "im:releaseDate"
private let CAT_KEY = "category"

struct Price {//: Mappable {
    var amount: Double?
    var currency: String = ""
    
//    init?(_ map: Map) {
//        
//    }
//    
//    mutating func mapping(map: Map) {
//        amount      <- map[AMOUNT_KEY]
//        currency    <- map[CURR_KEY]
//    }
}


//App Model Class
public class App: Object {
    
    //MARK : Properties
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var summary: String = ""
    dynamic var copyright: String = ""
    dynamic var title: String = ""
    var images = List<Image>()
    
    var category: Category?
    var price: Price?
    var releaseDate: NSDate?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
//    required convenience public init?(_ map: Map) {
//        self.init()
//        
////        mapping(map)
//    }
    
    //MARK : Mapping
    
//    public func mapping(map: Map) {
//        id          <- map[ID_KEY]
//        name        <- map[NAME_KEY]
//        summary     <- map[SUM_KEY]
//        copyright   <- map[COPY_KEY]
//        title       <- map[TITLE_KEY]
//        images      <- map[IMAGE_KEY]
//        category    <- map[CAT_KEY]
//        price       <- map[PRICE_KEY]
//        releaseDate <- (map[DATE_KEY], DateTransform())
//    }
    
    //MARK : init functions
    
    required public init() {
        super.init()
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
}
