//
//  Counters+CoreDataProperties.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 31/01/2022.
//
//

import Foundation
import CoreData


extension Counters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Counters> {
        return NSFetchRequest<Counters>(entityName: "Counters")
    }

    @NSManaged public var listItem: Int64
    @NSManaged public var list: Int64
    @NSManaged public var group: Int64

}

extension Counters : Identifiable {

}
