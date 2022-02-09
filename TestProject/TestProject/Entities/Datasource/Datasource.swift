//
//  DataSource.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

class Datasource: ProtocolDataRepository
{
  //MARK: DATA MEMBERS
  private var plugin: ProtocolDataSource?
  //END MEMBERS
  
  
  init(plugin: ProtocolDataSource?){
    guard plugin != nil else{
      //SOME ERROR SHOULD POP UP HERE
      self.plugin = nil
      return
    }
    self.plugin = plugin
  }
  
  func addGroup(groupName: String) -> Bool {
    let result = plugin?.addGroup(groupName: groupName)
    
    if result == nil || result! < 0
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
    return result!
  }
  
  func getPermanentListTitles() -> [Int : String]? {
    
    let lists = plugin?.getPermanentListTitles()
    
    guard lists != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func getPermanentListTitles")
      return nil
    }
    
    var result = [Int:String]()
    
    for i in lists!
    {
      result[Int(i.listKey)] = i.name
    }
    
    return result
  }
  
  func getActiveItems(listKey: Int) -> Int {
    
    let list = plugin?.getActiveItems(listKey: listKey)
    
    guard list != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func getActiveItems")
      return -1
    }
    
    return Int(exactly: list![0].activeTaskCount)!
  }
  
  func getGroups() -> [Group] {
    let groups = plugin?.getGroups()
    
    guard groups?.isEmpty != true else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func getGroups")
      return []
    }
    
    return groups!
  }
  
  func getGroupFreeListTitles() -> [Int : String]? {
    
    let lists = plugin?.getOptionalListTitles()
    
    guard lists != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func getGroupFreeListTitles")
      return nil
    }
    
    var result = [Int:String]()
    
    for i in lists!
    {
      if i.group == nil
      {
        result[Int(i.listKey)] = i.name
      }
    }
    
    return result
  }
  
  func getGroupCount() -> Int {
    let result = plugin?.getGroupsCount()
    if result == -1
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func getGroupCount")
    }
    return result ?? -1
  }
  
  func groupExists(groupName: String) -> Bool {
    
    let result = plugin?.groupExists(groupName: groupName)
    
    if result == nil
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: Datasource >> func groupExists")
      return true
    }
    return result!
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
