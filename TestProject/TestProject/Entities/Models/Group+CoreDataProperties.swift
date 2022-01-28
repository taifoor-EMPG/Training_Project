//
//  Group+CoreDataProperties.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String?
    @NSManaged public var lists: List?

}

extension Group : Identifiable {

}
