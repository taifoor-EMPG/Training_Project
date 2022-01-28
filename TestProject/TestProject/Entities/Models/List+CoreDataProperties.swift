//
//  List+CoreDataProperties.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var isPermanent: Bool
    @NSManaged public var name: String?
    @NSManaged public var activeTaskCount: Int64
    @NSManaged public var listItems: NSSet?
    @NSManaged public var group: Group?

}

// MARK: Generated accessors for listItems
extension List {

    @objc(addListItemsObject:)
    @NSManaged public func addToListItems(_ value: ListItem)

    @objc(removeListItemsObject:)
    @NSManaged public func removeFromListItems(_ value: ListItem)

    @objc(addListItems:)
    @NSManaged public func addToListItems(_ values: NSSet)

    @objc(removeListItems:)
    @NSManaged public func removeFromListItems(_ values: NSSet)

}

extension List : Identifiable {

}
