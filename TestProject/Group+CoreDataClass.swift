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
  
  func getListsArray() -> [List]
  {
    var listsArray:[List] = []
    let tempList = self.lists!.allObjects
    for i in tempList
    {
      listsArray.append(i as! List)
    }
    return listsArray
  }
}
