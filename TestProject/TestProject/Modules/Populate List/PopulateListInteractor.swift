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
  
  init(source : ProtocolDataRepository?)
  {
    guard source != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: PopulateListInteractor >> func init()")
      return
    }
    self.source = source
  }
  
  func setPresenter(presenter: ProtocolInteractorToPresenterPopulateList?)
  {
    guard presenter != nil else
    {
      //Error Occured
      LoggingSystemFlow.printLog("ERROR: PopulateListInteractor >> func setPresenter")
      return
    }
    self.presenter = presenter
  }
}

//MARK: Use Case Functionalities
extension PopulateListInteractor
{
  func getList(listName: String) -> List? {
    LoggingSystemFlow.printLog("PopulateListInteractor >> func getList")
    return nil
  }
  
  func changeListTitle(oldTitle: String, newTitle: String) -> Bool
  {
    LoggingSystemFlow.printLog("PopulateListInteractor >> func changeListTitle")
    return false
  }
  
  func allowEditing(_ listName: String) -> Bool {
    LoggingSystemFlow.printLog("PopulateListInteractor >> func allowEditing")
    return false
  }
}
