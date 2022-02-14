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
  
  func getListItemsArray() -> [ListItem]{
    var listItemsArray = [ListItem]()
    listItemsArray.removeAll()
    let temp = self.listItems?.allObjects
    for i in temp ?? []
    {
      listItemsArray.append(i as! ListItem)
    }
    return listItemsArray
  }
  
}
