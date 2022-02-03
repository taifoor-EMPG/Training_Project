//
//  Group+CoreDataProperties.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 31/01/2022.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String?
    @NSManaged public var groupKey: Int64
    @NSManaged public var lists: NSSet?

}

// MARK: Generated accessors for lists
extension Group {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: List)

    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: List)

    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)

}

extension Group : Identifiable {

}
