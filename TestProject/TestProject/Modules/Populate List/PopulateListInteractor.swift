//
//  PopulateListInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateListInteractor: ProtocolPresenterToInteractorPopulateList
{
  //MARK: DATA MEMBERS
  
  private weak var presenter: ProtocolInteractorToPresenterPopulateList?
  private var source: ProtocolDataRepository?
  
  //END OF DATA MEMBERS
  
  init(source : ProtocolDataRepository){
    self.source = source
  }
  
  func setPresenter(presenter: ProtocolInteractorToPresenterPopulateList){
    self.presenter = presenter
  }
}

//MARK: Use Case Functionalities
extension PopulateListInteractor
{
  //REcheck this
  func getList(listKey: Int) -> List? {
    let result = source?.getList(listKey: listKey)
    
    if result == nil
    {
      print("PopulateListInteractor >> In getList >> Error: Failed to Fetch")
      return nil
    }
    return result
  }
  
  //Recheck this
  func changeListTitle(listKey: Int, newTitle: String) -> Bool
  {
    //Check if List with newTitle exists
    var result = source?.listExists(listName: newTitle)
    if result == nil || result == true
    {
      return false
    }
    
    //Rename the List with ListKey
    result = source?.changeListName(listKey: listKey, newListName: newTitle)
    if result == nil
    {
      LoggingSystemFlow.printLog("PopulateListInteractor >> In changeListTitle")
      return false
    }
    return result!
  }
  
  //recheck this
  func allowEditing(listKey: Int) -> Bool {
    let result = source?.allowEditing(listKey: listKey)
    
    if result == nil
    {
      print("PopulateListInteractor >> In allowEditing >> Error: Failed to Fetch")
      return false
    }
    return result!
  }
  
  func changeItemStatus(itemKey: Int, newStatus: Bool) {
    source?.changeStatusOfItem(itemKey: itemKey, newStauts: newStatus)
  }
  func changeItemText(itemKey: Int, newText: String) {
    source?.changeTextOfItem(itemKey: itemKey, newText: newText)
  }
  
  func newListItem(listKey: Int, text: String) {
    let result = source?.addItemtoList(listKey: listKey, itemText: text)
    
    if result == nil || result == false
    {
      print("PopulateListInteractor >> In newListItem >> Error: Failed to Fetch")
    }
  }
  
  func deleteListItem(listKey: Int, itemKey: Int) -> Bool {
    let result = source?.removeItemFromList(listKey: listKey, itemKey: itemKey)
    
    if result == nil || result == false
    {
      print("PopulateListInteractor >> In newListItem >> Error: Failed to Fetch")
      return false
    }
    return true
  }
}
