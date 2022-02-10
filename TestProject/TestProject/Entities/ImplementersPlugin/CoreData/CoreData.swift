//
//  CoreData.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import CoreData
import UIKit

class CoreData: ProtocolDataSource
{
  //MARK: DATA MEMBERS
  private let context: NSManagedObjectContext
  private let manager: ProtocolCoreDataManager
  
  struct DatabaseConstants
  {
    static let lists = ["listKey", "name", "isPermanent"]
    static let listItems = ["itemKey", "text", "done"]
    static let counter = ["list", "listItem", "group"]
    static let group = ["groupKey", "name"]
  }
  
  //END OF DATA MEMBERS
  
  
  //Initializer to Instantiate Core Data Class
  init(CoreDataManager: ProtocolCoreDataManager = CoreDataManager.shared)
  {
    self.manager = CoreDataManager
    context = manager.persistentContainer.viewContext
  }
  
  //MARK: CRUD FUNCTIONALITIES
  ///Refer to ProtocolDataSource for implementational details
  
  ///CREATE
  func addGroup(groupName: String) -> Int{
    do
    {
      let request = Counters.fetchRequest() as NSFetchRequest<Counters>
      let counter = try context.fetch(request)
      
      let key = counter[0].group
      counter[0].group += 1
      
      let mygroup = Group(context: context)
      mygroup.groupKey = key
      mygroup.name = groupName
      
      try self.context.save()
      return Int(key)
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func getPermanentListTitles")
      return -1
    }
  }
  func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
    do
    {
      let requestGroup = Group.fetchRequest() as NSFetchRequest<Group>
      let predicateGroup = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
      requestGroup.predicate = predicateGroup
      
      let group = try context.fetch(requestGroup)
      
      if group.isEmpty == true
      {
        return false
      }
      
      let requestList = List.fetchRequest() as NSFetchRequest<List>
      let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      requestList.predicate = predicateList
      
      let lists = try context.fetch(requestList)
      
      if lists.isEmpty == true
      {
        return false
      }
      
      
      group[0].addToLists(lists[0])
      
      try self.context.save()
      return true
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> In addListToGroup")
      return false
    }
  }
  func addOptionalList(listName: String) -> Int {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> In addOptionalList")
    return -1
  }
  func addItemtoList(listKey: Int, itemText: String) -> Int {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> In addItemtoList")
    return -1
  }
  
  ///READ
  
  func getPermanentListTitles(completion: @escaping (([List]?) -> Void)){
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[2] + " == true")
      request.predicate = predicate
      
      let sort = NSSortDescriptor(key: DatabaseConstants.lists[0], ascending: true)
      request.sortDescriptors = [sort]
      
      let lists = try context.fetch(request)
      
      completion(lists)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func getPermanentListTitles")
      completion(nil)
    }
  }
  func getOptionalListTitles(completion: @escaping (([List]?) -> Void)){
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[2] + " == false")
      request.predicate = predicate
      
      let sort = NSSortDescriptor(key: DatabaseConstants.lists[0], ascending: true)
      request.sortDescriptors = [sort]
      
      let lists = try context.fetch(request)
      
      completion(lists)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func getOptionalListTitles")
      completion(nil)
    }
  }
  func getActiveItems(listKey: Int, completion: @escaping (([List]?) -> Void)){
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      completion(list)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func getActiveItems")
      completion(nil)
    }
  }
  func getGroupsCount(completion: @escaping ((Int) -> Void)){
    do
    {
      let request = Group.fetchRequest() as NSFetchRequest<Group>
      let groups = try context.fetch(request)
      completion(groups.count)
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func getGroupsCount")
      completion(-1)
    }
  }
  func getGroups(completion: @escaping (([Group]) -> Void)){
    do
    {
      let request = Group.fetchRequest() as NSFetchRequest<Group>
      let groups = try context.fetch(request)
      completion(groups)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func getGroups")
      completion([])
    }
  }
  func groupExists(groupName: String, completion: @escaping ((Bool) -> Void)){
    do
    {
      let request = Group.fetchRequest() as NSFetchRequest<Group>
      let predicate = NSPredicate(format: DatabaseConstants.group[1] + " == '" + String(groupName) + "'")
      request.predicate = predicate
      
      let group = try context.fetch(request)
      
      let doesExist = !group.isEmpty
      completion(doesExist)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func groupExists")
      completion(false)
    }
  }
  
  
  ///UPDATE
  func changeGroupName(groupKey: Int, newGroupName: String) -> Bool {
    do
    {
      let request = Group.fetchRequest() as NSFetchRequest<Group>
      let predicate = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
      request.predicate = predicate
      
      let group = try context.fetch(request)
      
      if group.isEmpty == true
      {
        return false
      }
      
      group[0].name = newGroupName
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func changeGroupName")
      return false
    }
  }
  
  ///DELETE
  func removeGroup(groupKey: Int) -> Bool {
    do
    {
      let request = Group.fetchRequest() as NSFetchRequest<Group>
      let predicate = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
      request.predicate = predicate
      
      let group = try context.fetch(request)
      
      if group.isEmpty == true
      {
        return false
      }
      
      self.context.delete(group[0])
      
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func removeGroup")
      return false
    }
  }
  func ungroup(groupKey: Int) -> Bool {
    do
    {
      let requestGroup = Group.fetchRequest() as NSFetchRequest<Group>
      let predicateGroup = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
      requestGroup.predicate = predicateGroup
      
      let group = try context.fetch(requestGroup)
      
      if group.isEmpty == true
      {
        return false
      }
      
      let requestList = List.fetchRequest() as NSFetchRequest<List>
      let predicateList = NSPredicate(format: DatabaseConstants.lists[2] + " == false")
      requestList.predicate = predicateList
      
      let lists = try context.fetch(requestList)
      
      for i in lists
      {
        if i.group == nil
        {
          return false
        }
        else
        {
          if Int(i.group?.groupKey ?? Int64(Constants.newGroupKey)) == groupKey
          {
            group[0].removeFromLists(i)
          }
        }
      }
      
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func ungroup")
      return false
    }
  }
  func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool {
    do
    {
      let requestGroup = Group.fetchRequest() as NSFetchRequest<Group>
      let predicateGroup = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
      requestGroup.predicate = predicateGroup
      
      let group = try context.fetch(requestGroup)
      
      if group.isEmpty == true
      {
        return false
      }
      
      let requestList = List.fetchRequest() as NSFetchRequest<List>
      let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      requestList.predicate = predicateList
      
      let lists = try context.fetch(requestList)
      
      if lists.isEmpty == true
      {
        return false
      }
      
      
      group[0].removeFromLists(lists[0])
      
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func removeListFromGroup")
      return false
    }
  }
  
  
  //MARK: Further Processing Required
  func removeOptionalList(listKey: Int) -> Bool {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func removeOptionalList")
    return false
  }
  
  func removeItemFromList(listKey: Int, itemKey: Int) -> Bool {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func removeItemFromList")
    return false
  }
  
  func mark(listItemKey: Int) -> Bool {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func mark")
    return false
  }
  
  func getListSize(listKey: Int) -> Int {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func getListSize")
    return -1
  }
  
  func changeListName(listKey: Int, newListName: String) -> Bool {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func changeListName")
    return false
  }
  
  func changeTextOfItem(itemKey: Int, newText: String) -> Bool {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func changeTextOfItem")
    return false
  }
  
  func getListItems(listkey: Int) -> [Int : (text: String, status: Bool)] {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func getListItems")
    return [:]
  }
  
  func getLists() -> [Int : String] {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func getLists")
    return [:]
  }
  
  func getGroupSize(groupKey: Int) -> Int {
    LoggingSystemFlow.printLog("ERROR: In CoreData >> func getGroupSize")
    return -1
  }
}
