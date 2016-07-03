//
//  Place.swift
//  RappiApp
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//


import Foundation
import ObjectMapper


private let ID_KEY = "id.attributes.im:id"
private let NAME_KEY = "im:name.label"
private let SUM_KEY = "summary.label"
private let COPY_KEY = "rights.label"
private let PRICE_KEY = "im:price.attributes.amount"
private let TITLE_KEY = "title.label"
private let IMAGE_KEY = "im:image.2.label"
private let LINK_KEY = "link.attributes.href"
private let DATE_KEY = "im:releaseDate.attributes.label"
private let CAT_KEY = "category.attributes.label"

//App Model Class
public class App: Mappable {
    
    //MARK : Properties
    
    var id: String = ""
    var name: String = ""
    var summary: String = ""
    var copyright: String = ""
    var title: String = ""
    var imageURL: String = ""
    var category: String = ""
    var linkURL: String = ""
    var price: Float = 0.0
    var releaseDate: NSDate?
    
    required convenience public init?(_ map: Map) {
        self.init()
    }
    
    //MARK : Mapping
    
    public func mapping(map: Map) {
        id          <- map[ID_KEY]
        name        <- map[NAME_KEY]
        summary     <- map[SUM_KEY]
        copyright   <- map[COPY_KEY]
        title       <- map[TITLE_KEY]
        category    <- map[CAT_KEY]
        price       <- map[PRICE_KEY]
        imageURL    <- map[IMAGE_KEY]
        linkURL     <- map[LINK_KEY]
        releaseDate <- (map[DATE_KEY], DateTransform())
    }
    
    //MARK : init functions
    
    init(){
    
    }
}
