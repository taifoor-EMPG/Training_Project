//
//  ListItem+CoreDataProperties.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//
//

import Foundation
import CoreData


extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem")
    }

    @NSManaged public var text: String?
    @NSManaged public var done: Bool
    @NSManaged public var list: List?

}

extension ListItem : Identifiable {

}
