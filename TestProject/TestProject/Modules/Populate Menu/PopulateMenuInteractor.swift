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
  func createGroup(groupName: String, completion: @escaping ((Bool) -> Void)){
    
    //Check if group with same name exists
    
    var name = groupName
    var count = 1
    var doesExist = true
    
    source?.groupExists(groupName: name, completion: { [self] result in
      doesExist = result
      while doesExist == true
      {
        name = groupName + " " + String(count)
        source?.groupExists(groupName: name, completion: { newResult in
          doesExist = newResult
          count += 1
        })
      }
    
      let isAdded = source?.addGroup(groupName: name)
      if isAdded == nil
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func createGroup")
      }
      completion(isAdded ?? false)
    })
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
  func getPermanentListTitles(completion: @escaping (([Int : String]) -> Void)){
    source?.getPermanentListTitles(completion: { result in
      if result == nil
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getPermanentListTitles")
      }
      completion(result ?? [:])
    })
  }
  
  func getListActiveCount(listKey: Int, completion: @escaping ((Int) -> Void)){
    source?.getActiveItems(listKey: listKey, completion: { result in
      if result == -1
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getListActiveCount")
      }
      completion(result)
    })
  }
  
  func getGroupFreeListTitles(completion: @escaping (([Int : String]) -> Void)){
    source?.getGroupFreeListTitles(completion: { result in
      if result == nil
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getGroupFreeListTitles")
      }
      completion(result ?? [:])
    })
  }
  
  func getGroupCount(completion: @escaping ((Int) -> Void)){
    source?.getGroupCount(completion: { result in
      if result == -1
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func getGroupCount")
      }
      completion(result)
    })
  }
  
  func getGroupTitles(groupKey: Int, completion: @escaping (([Int : String]) -> Void)){
    source?.getPermanentListTitles(completion: { result in
      completion(result ?? [:])
    })
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
  
  func getGroups(completion: @escaping (([Group]?) -> Void)){
    source?.getGroups(completion: { result in
      completion(result)
    })
  }
  
  //MARK: CRUD - UPDATE
  func renameList(listKey: Int, newName: String) -> Bool {
    LoggingSystemFlow.printLog("PopulateMenuInteractor >> In renameList")
    return false
  }
  
  func renameGroup(groupKey: Int, newName: String, completion: @escaping ((Bool) -> Void)){
    //Check if group with newName exists
    
    source?.groupExists(groupName: newName, completion: { [self] result in
      if result == true
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func renameGroup")
        completion(false)
      }
      
      let newResult = source?.changeGroupName(groupKey: groupKey, newGroupName: newName)
      
      if newResult == nil || newResult == false
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func renameGroup")
        completion(false)
      }
      completion(true)
    })
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
