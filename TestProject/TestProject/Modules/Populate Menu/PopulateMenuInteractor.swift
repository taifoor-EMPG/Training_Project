//
//  PopulateMenuInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import Foundation

//MARK: - All Methods that the Presenter can call to get information from API/DB come here

class PopulateMenuInteractor: ProtocolPresenterToInteractorPopulateMenu
{
  //MARK: Data Members
  private weak var presenter: ProtocolInteractorToPresenterPopulateMenu?
  private var source: ProtocolDataRepository?
  //End of Data Members
  
  
  init(source : ProtocolDataRepository?)
  {
    guard source != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func init()")
      return
    }
    self.source = source
  }
  
  func setPresenter(presenter: ProtocolInteractorToPresenterPopulateMenu?)
  {
    guard presenter != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func setPresenter")
      return
    }
    self.presenter = presenter
  }
  
  //MARK: CRUD - CREATE
  func createGroup(groupName: String) -> Bool {
    
    //Check if group with same name exists
    
    var name = groupName
    var count = 1
    var result = source?.groupExists(groupName: name)
    
    while result == true
    {
      name = groupName + " " + String(count)
      result = source?.groupExists(groupName: name)
      count += 1
    }
    
    let isAdded = source?.addGroup(groupName: name)
    if isAdded == nil
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func createGroup")
    }
    return isAdded ?? false
  }
  
  func createList(listName: String) -> Int {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> func createList")
    return -1
  }
  
  func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
    let result = source?.addListToGroup(listKey: listKey, groupKey: groupKey)
    if result == nil
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func addListToGroup")
    }
    return result ?? false
  }
  
  //MARK: CRUD - READ
  func getPermanentListTitles() -> [Int : String] {
    let result = source?.getPermanentListTitles()
    if result == nil
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getPermanentListTitles")
    }
    return result ?? [:]
  }
  
  func getListActiveCount(listKey: Int) -> Int {
    let result = source?.getActiveItems(listKey: listKey)
    if result == -1
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getListActiveCount")
    }
    return result ?? -1
  }
  
  func getGroupFreeListTitles() -> [Int : String] {
    let result = source?.getGroupFreeListTitles()
    if result == nil
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getGroupFreeListTitles")
    }
    return result ?? [:]
  }
  
  func getGroupCount() -> Int {
    let result = source?.getGroupCount()
    if result == -1
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getGroupCount")
    }
    return result ?? -1
  }
  
  func getGroupTitles(groupKey: Int) -> [Int : String] {
    return (source?.getPermanentListTitles())!
  }
  
  func getGroupListCount(groupKey: Int) -> Int {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In getGroupListCount")
    return -1
  }
  
  func getGroupListTitles(groupKey: Int) -> [Int : String] {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In getGroupListTitles")
    return [:]
  }
  func getListTitle(listKey: Int) -> String {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In getListTitle")
    return ""
  }
  
  func getGroups() -> [Group]? {
    let result = source?.getGroups()
    if result == nil
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getGroups")
    }
    return result ?? nil
  }
  
  //MARK: CRUD - UPDATE
  func renameList(listKey: Int, newName: String) -> Bool {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In renameList")
    return false
  }
  
  func renameGroup(groupKey: Int, newName: String) -> Bool {
    //Check if group with newName exists
    var result = source?.groupExists(groupName: newName)
    if result == nil || result == true
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func renameGroup")
      return false
    }
    
    //Rename the Group with groupKey
    result = source?.changeGroupName(groupKey: groupKey, newGroupName: newName)
    if result == nil || result == false
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func renameGroup")
      return false
    }
    return true
  }
  
  func ungroup(groupKey: Int) -> Bool {
    let result = source?.ungroup(groupKey: groupKey)
    if result == nil || result == false
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func ungroup")
      return false
    }
    return true
  }
  
  //MARK: CRUD - DELETE
  func deleteGroup(groupKey: Int) -> Bool {
    let result = source?.removeGroup(groupKey: groupKey)
    if result == nil || result == false
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func deleteGroup")
      return false
    }
    return true
  }
  
  func deleteList(listKey: Int) -> Bool {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In deleteList")
    return false
  }
  
  func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool {
    let result = source?.removeListFromGroup(listKey: listKey, groupKey: groupKey)
    if result == nil || result == false
    {
      //ERROR
      LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func removeListFromGroup")
      return false
    }
    return true
  }
  func deleteList(listKey: Int) -> [Group]? {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In deleteList")
    return nil
  }
}
