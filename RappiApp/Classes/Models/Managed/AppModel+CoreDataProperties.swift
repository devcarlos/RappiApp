//
//  AppModel+CoreDataProperties.swift
//  
//
//  Created by Carlos Alcala on 7/2/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AppModel {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var summary: String?
    @NSManaged var price: NSNumber?
    @NSManaged var title: String?
    @NSManaged var copyright: String?
    @NSManaged var imageURL: String?
    @NSManaged var category: String?
    @NSManaged var linkURL: String?
    @NSManaged var releaseDate: NSDate?

}
