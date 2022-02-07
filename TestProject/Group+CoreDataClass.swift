//
//  Group+CoreDataClass.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 31/01/2022.
//
//

import Foundation
import CoreData

@objc(Group)
public class Group: NSManagedObject {

    //DATA MEMBERS
    var listsArray:[List] = []
    //END OF DATA MEMBERS
    
    func setListsArray()
    {
        listsArray.removeAll()
        let temp = self.lists!.allObjects
        for i in temp
        {
            listsArray.append(i as! List)
        }
    }
    
    func myprint()
    {
        print("Group Key: \(self.groupKey)")
        print("Name: \(String(describing: self.name))")
        
        setListsArray()
        
        for i in self.listsArray
        {
            i.myprint()
        }
        
    }
}
