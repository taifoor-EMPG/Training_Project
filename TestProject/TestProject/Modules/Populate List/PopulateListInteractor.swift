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
  func getList(listKey: Int){
    source?.getList(listKey: listKey, completion: { result in
      if result == nil
      {
        LoggingSystemFlow.printLog("PopulateListInteractor >> In getList >> Error: Failed to Fetch")
        return
      }
      else
      {
        self.presenter?.setList(result ?? nil)
      }
    })
  }
  
  func changeListTitle(listKey: Int, newTitle: String, completion: @escaping ((Bool) -> Void))
  {
    //Check if List with newName exists
    
    source?.listExists(listName: newTitle, completion: { result in
      if result == true
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateListInteractor >> func changeListTitle")
        completion(false)
      }
      
      let newResult = self.source?.changeListName(listKey: listKey, newListName: newTitle)
      if newResult == nil || newResult == false
      {
        //ERROR
        LoggingSystemFlow.printLog("ERROR: PopulateMenuInteractor >> func changeListTitle")
        completion(false)
      }
      completion(true)
    })
  }
  
  func allowEditing(listKey: Int){
    source?.allowEditing(listKey: listKey, completion: { result in
      self.presenter?.setEditingPermission(!result)
    })
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
      LoggingSystemFlow.printLog("PopulateListInteractor >> In newListItem >> Error: Failed to Fetch")
    }
  }
  
  func deleteListItem(listKey: Int, itemKey: Int) -> Bool {
    let result = source?.removeItemFromList(listKey: listKey, itemKey: itemKey)
    
    if result == nil || result == false
    {
      LoggingSystemFlow.printLog("PopulateListInteractor >> In newListItem >> Error: Failed to Fetch")
      return false
    }
    return true
  }
  func setListColor(listKey: Int, color: String) {
    source?.setListColor(listKey: listKey, color: color)
  }
}
