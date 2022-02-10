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
  
  func addGroup(groupName: String) -> Bool {
    let result = plugin?.addGroup(groupName: groupName)
    
    guard result == nil, result ?? 0 < 0 else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func addGroup")
      return false
    }
    
    return true
  }
  
  func addOptionalList(listName: String) -> Bool {
    LoggingSystemFlow.printLog("In Datasource >> func addOptionalList")
    return false
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
  
  func getGroupTitles(groupKey: Int) -> [Int : String] {
    LoggingSystemFlow.printLog("In Datasource >> In getGroupTitles")
    return [:]
  }
  
  func getGroupSize(GroupKey: Int) -> Int {
    LoggingSystemFlow.printLog("In Datasource >> In getGroupSize")
    return -1
  }
  
  func getGroupListTitles(groupKey: Int) -> [Int : String]? {
    LoggingSystemFlow.printLog("In Datasource >> In getGroupListTitles")
    return nil
  }
  
  func changeListName(listKey: Int, newListName: String) -> Bool {
    LoggingSystemFlow.printLog("In Datasource >> In changeListName")
    return false
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
    LoggingSystemFlow.printLog("In Datasource >> In deleteList")
    return false
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
}
