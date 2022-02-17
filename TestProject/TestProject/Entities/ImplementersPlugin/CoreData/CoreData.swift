//
//  CoreData.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation
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
  
  func addOptionalList(listName: String) -> Int {
    do
    {
      let request = Counters.fetchRequest() as NSFetchRequest<Counters>
      let counter = try context.fetch(request)
      
      let key = counter[0].list
      counter[0].list += 1
      
      let newList = List(context: context)
      newList.listKey = key
      newList.name = listName
      newList.isPermanent = false
      newList.color = "default"
      
      try self.context.save()
      return Int(key)
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func addOptionalList")
      return Constants.newListKey
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
  
  func addItemtoList(listKey: Int, itemText: String) -> Int {
    do
    {
      let requestList = List.fetchRequest() as NSFetchRequest<List>
      let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      requestList.predicate = predicateList
      
      let list = try context.fetch(requestList)
      
      if list.isEmpty == true
      {
        return -1
      }
      
      let requestCounters = Counters.fetchRequest() as NSFetchRequest<Counters>
      let counter = try context.fetch(requestCounters)
      
      if counter.isEmpty == true
      {
        return -1
      }
      
      let key = counter[0].listItem
      counter[0].listItem += 1
      
      let newListItem = ListItem(context: context)
      newListItem.itemKey = key
      newListItem.text = itemText
      newListItem.done = false
      
      list[0].addToListItems(newListItem)
      
      try self.context.save()
      return Int(key)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> In addItemtoList")
      return -1
    }
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
  
  //MARK: RECHECK THIS
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

  func listExists(listName: String, completion: @escaping ((Bool) -> Void)){
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[1] + " == '" + String(listName) + "'")
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      let doesExist = !list.isEmpty
      completion(doesExist)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Datasource >> func listExists >> Failed to Fetch")
      completion(false)
    }
  }

  func getList(listKey: Int, completion: @escaping ((List?) -> Void)){
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      if list.isEmpty == true
      {
        completion(nil)
      }
      
      completion(list[0])
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Datasource >> func getList >> Failed to Fetch")
      completion(nil)
    }
  }

  func allowEditing(listKey: Int, completion: @escaping ((Bool?) -> Void)){
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      if list.isEmpty == true
      {
        completion(nil)
      }
      
      completion(!list[0].isPermanent)
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Datasource >> func allowEditing >> Failed to Fetch")
      completion(nil)
    }
  }
  
  func search(query: String, completion: @escaping ([Results]?) -> Void) {
    do
    {
      var toReturn = [Results]()
      
      //Search List Titles
      let requestList = List.fetchRequest() as NSFetchRequest<List>
      let predicateList = NSPredicate(format: DatabaseConstants.lists[1] + " contains[c] %@", query)
      requestList.predicate = predicateList
      
      let lists = try context.fetch(requestList)
      
      if lists.isEmpty == false
      {
        for list in lists
        {
          var match = Results()
          match.listKey = Int(list.listKey)
          match.path = (list.name ?? "ListName")
          toReturn.append(match)
        }
      }
      
      //Search List Items
      let requestListItems = ListItem.fetchRequest() as NSFetchRequest<ListItem>
      let predicateListItems = NSPredicate(format: DatabaseConstants.listItems[1] + " contains[c] %@", query)
      requestListItems.predicate = predicateListItems
      
      let listItems = try context.fetch(requestListItems)
      
      if listItems.isEmpty == false
      {
        for item in listItems
        {
          var match = Results()
          match.listKey = Int(item.list?.listKey ?? Int64(Constants.newListKey))
          match.path = (item.list?.name ?? "ListName") + " > " + (item.text ?? "Some Item")
          toReturn.append(match)
        }
      }
      completion(toReturn)
    }
    catch
    {
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func search")
      completion(nil)
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
  
  func changeListName(listKey: Int, newListName: String) -> Bool {
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      if list.isEmpty == true
      {
        return false
      }
      
      list[0].name = newListName
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func changeListName")
      return false
    }
  }
  
  func mark(listItemKey: Int, newStatus: Bool) -> Bool {
    do
    {
      let request = ListItem.fetchRequest() as NSFetchRequest<ListItem>
      let predicate = NSPredicate(format: DatabaseConstants.listItems[0] + " == " + String(listItemKey))
      request.predicate = predicate
      
      let listItem = try context.fetch(request)
      
      if listItem.isEmpty == true
      {
        return false
      }
      
      listItem[0].done = newStatus
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func mark")
      return false
    }
  }
  
  func changeTextOfItem(itemKey: Int, newText: String) -> Bool {
    do
    {
      let request = ListItem.fetchRequest() as NSFetchRequest<ListItem>
      let predicate = NSPredicate(format: DatabaseConstants.listItems[0] + " == " + String(itemKey))
      request.predicate = predicate
      
      let listItem = try context.fetch(request)
      
      if listItem.isEmpty == true
      {
        return false
      }
      
      listItem[0].text = newText
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func changeTextOfItem")
      return false
    }
  }
  
  func setListColor(listKey: Int, color: String) {
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      if list.isEmpty == true
      {
        LoggingSystemFlow.printLog("ERROR: In CoreData >> func setListColor >> List Not Found")
        return
      }
      
      list[0].color = color
      try self.context.save()
      return
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func setListColor")
      return
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
  
  func removeOptionalList(listKey: Int) -> Bool {
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      request.predicate = predicate
      
      let list = try context.fetch(request)
      
      if list.isEmpty == true
      {
        return false
      }
      
      self.context.delete(list[0])
      
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      print("Core >> In removeOptionalList >> Failed to Fetch Data")
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
        if i.group != nil
        {
          if  Int(i.group!.groupKey) == groupKey
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
  
  func removeItemFromList(listKey: Int, itemKey: Int) -> Bool {
    do
    {
      let requestList = List.fetchRequest() as NSFetchRequest<List>
      let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
      requestList.predicate = predicateList
      
      let list = try context.fetch(requestList)
      
      if list.isEmpty == true
      {
        return false
      }
      
      let requestListItem = ListItem.fetchRequest() as NSFetchRequest<ListItem>
      let predicateListItem = NSPredicate(format: DatabaseConstants.listItems[0] + " == " + String(itemKey))
      requestListItem.predicate = predicateListItem
      
      let listsItem = try context.fetch(requestListItem)
      
      if listsItem.isEmpty == true
      {
        return false
      }
      
      list[0].removeFromListItems(listsItem[0])
      self.context.delete(listsItem[0])
      
      try self.context.save()
      return true
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In CoreData >> func removeItemFromList")
      return false
    }
  }
}
