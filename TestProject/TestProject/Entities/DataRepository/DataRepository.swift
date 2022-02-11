//
//  DataSource.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

class DataRepository: ProtocolDataRepository
{
  //MARK: DATA MEMBERS
  private var plugin: ProtocolDataSource?
  //END MEMBERS
  
  init(plugin: ProtocolDataSource){
    self.plugin = plugin
  }
  
  
  //MARK: CREATE OPERATIONS
  func addGroup(groupName: String) -> Int {
    let result = plugin?.addGroup(groupName: groupName)
    
    guard result != nil || (result ?? 0) > 0 else{
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func addGroup")
      return -1
    }
    return result ?? -1
  }
  
  func addOptionalList(listName: String) -> Int {
    let result = plugin?.addOptionalList(listName: listName)
    guard result != nil else
    {
      LoggingSystemFlow.printLog("In Datasource >> func addOptionalList")
      return -1
    }
    return result ?? -1
  }
  
  func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
    let result = plugin?.addListToGroup(listKey: listKey, groupKey: groupKey)
    guard result != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func addListToGroup")
      return false
    }
    return result ?? false
  }
  
  func addItemtoList(listKey: Int, itemText: String) -> Bool {
    let result = plugin?.addItemtoList(listKey: listKey, itemText: itemText)
    if result == nil || result ?? -1 < 0
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func addItemtoList")
      return false
    }
    return true
  }
  
  //MARK: READ OPERATIONS
  func getPermanentListTitles(completion: @escaping (([Int : String]?) -> Void)){
    plugin?.getPermanentListTitles(completion: { lists in
      guard lists != nil else
      {
        //Error Occured
        LoggingSystemFlow.printLog("ERROR: Datasource >> func getPermanentListTitles")
        completion(nil)
        return
      }
      
      var result = [Int:String]()
      for i in lists ?? []
      {
        result[Int(i.listKey)] = i.name
      }
      completion(result)
    })
  }
  
  func getActiveItems(listKey: Int, completion: @escaping ((Int) -> Void)){
    plugin?.getActiveItems(listKey: listKey, completion: { list in
      guard list != nil else
      {
        //Error Occured
        LoggingSystemFlow.printLog("ERROR: Datasource >> func getActiveItems")
        completion(-1)
        return
      }
      
      var listItems:[ListItem] = []
      let tempListItems = list?[0].listItems?.allObjects
      for i in tempListItems ?? []
      {
        listItems.append(i as! ListItem)
      }
      var count = 0
      for i in listItems
      {
        if i.done == false
        {
          count += 1
        }
      }
      
      completion(count)
    })
  }
  
  func getGroups(completion: @escaping (([Group]) -> Void)){
    plugin?.getGroups(completion: { groups in
      
      guard groups.isEmpty != true else
      {
        //Error Occured
        LoggingSystemFlow.printLog("ERROR: Datasource >> func getGroups")
        completion([])
        return
      }
      return completion(groups)
    })
  }
  
  func getGroupFreeListTitles(completion: @escaping (([Int : String]?) -> Void)){
    plugin?.getOptionalListTitles(completion: { lists in
      guard lists != nil else
      {
        //Error Occured
        LoggingSystemFlow.printLog("ERROR: Datasource >> func getGroupFreeListTitles")
        completion(nil)
        return
      }
      var result = [Int:String]()
      for i in lists ?? []
      {
        if i.group == nil
        {
          result[Int(i.listKey)] = i.name
        }
      }
      completion(result)
    })
  }
  
  func getGroupCount(completion: @escaping ((Int) -> Void)){
    plugin?.getGroupsCount(completion: { result in
      completion(result)
    })
  }
  
  func groupExists(groupName: String, completion: @escaping ((Bool) -> Void)){
    plugin?.groupExists(groupName: groupName, completion: { result in
      completion(result)
    })
  }
  
  func searchQuery(query: String, completion: @escaping (([Results]?) -> Void)) {
    plugin?.search(query: query, completion: { results in
      completion(results)
    })
  }
  
  //MARK: Convert this to closure pattern
  func listExists(listName: String) -> Bool {
    let x = plugin?.listExists(listName: listName)
    
    if x == nil
    {
      print("Datasource >> In listExists >> Error: Failed to Retrieve Count")
      return true
    }
    return x ?? true
  }
  
  //MARK: Convert this to closure pattern
  func allowEditing(listKey: Int) -> Bool? {
    let x = plugin?.allowEditing(listKey: listKey)
    if x == nil
    {
      print("In DataSource >> allowEditing >> Error: Failed to Fetch")
      return nil
    }
    return x
  }
  
  //MARK: Convert this to closure pattern
  func getList(listKey: Int) -> List? {
    let x = plugin?.getList(listKey: listKey)
    if x == nil
    {
      print("In DataSource >> getList >> Error: Failed to Fetch")
      return nil
    }
    return x
  }
  
  //MARK: UPDATE OPERATIONS
  func changeListName(listKey: Int, newListName: String) -> Bool {
    let result = plugin?.changeListName(listKey: listKey, newListName: newListName)
    if result == nil || result == false
    {
      LoggingSystemFlow.printLog("In Datasource >> In changeListName")
      return false
    }
    return true
  }
  
  func changeGroupName(groupKey: Int, newGroupName: String) -> Bool {
    let result = plugin?.changeGroupName(groupKey: groupKey, newGroupName: newGroupName)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func changeGroupName")
      return false
    }
    return true
  }
  
  func changeStatusOfItem(itemKey: Int, newStauts: Bool) {
    let result = plugin?.mark(listItemKey: itemKey, newStatus: newStauts)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func changeStatusOfItem")
    }
  }
  
  func changeTextOfItem(itemKey: Int, newText: String) {
    let result = plugin?.changeTextOfItem(itemKey: itemKey, newText: newText)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func changeTextOfItem")
    }
  }
  
  //MARK: DELETE OPERATIONS
  func ungroup(groupKey: Int) -> Bool {
    let result = plugin?.ungroup(groupKey: groupKey)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func ungroup")
      return false
    }
    return true
  }
  
  func removeGroup(groupKey: Int) -> Bool {
    let result = plugin?.removeGroup(groupKey: groupKey)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func removeGroup")
      return false
    }
    return true
  }
  
  func deleteList(listKey: Int) -> Bool {
    let result = plugin?.removeOptionalList(listKey: listKey)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("In Datasource >> In deleteList")
      return false
    }
    return true
  }
  
  func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool {
    let result = plugin?.removeListFromGroup(listKey: listKey, groupKey: groupKey)
    if result == nil || result == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func removeListFromGroup")
      return false
    }
    return true
  }
  
  func removeItemFromList(listKey: Int, itemKey: Int) -> Bool {
    let result = plugin?.removeItemFromList(listKey: listKey, itemKey: itemKey)
    if result == nil || (result ?? false) == false
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func removeItemFromList")
      return false
    }
    return true
  }
}
