//
//  List+CoreDataClass.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//
//

import Foundation
import CoreData

@objc(List)
public class List: NSManagedObject {
    
    func myprint()
    {
        print("List Key: \(self.listKey)")
        print("Name: \(String(describing: self.name))")
        print("Permanent: \(self.isPermanent)")
        print("Group: \(String(describing: self.group))")
        print("Items: \(String(describing: self.listItems))")
    }
    
    
    public func newList(listKey: Int, name: String?, isPermanent: Bool)
    {
        self.listKey = Int64(listKey)
        self.name = name
        self.isPermanent = isPermanent
        activeTaskCount = 0
    }
    
    
    
    public func addItemsToList(listItems: [ListItem])
    {
        var active = 0
        for i in listItems
        {
            if i.done == false
            {
                active += 1
            }
            self.addToListItems(i)
        }
        self.activeTaskCount += Int64(active)
    }
}
