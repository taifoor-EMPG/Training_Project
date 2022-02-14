//
//  PopulateMenuProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol ProtocolViewToPresenterSearch
{
  //Setting Up View
  func initInteractor()
  
  //Navigation to Other Screens
  func pushToOpenList(listKey: Int)
  
  //Setting View Table
  func setupCell(cell: ResultCell, index: Int) -> ResultCell
  func getRowCount() -> Int
  func fetchData(query: String)
  
  //Misc Functions to Populate View
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol ProtocolPresenterToViewSearch: AnyObject
{
  //Function to Open List Should be here and implemented on the backend
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol ProtocolPresenterToInteractorSearch: AnyObject
{
  func setPresenter(presenter: ProtocolInteractorToPresenterSearch)
  func fetchResults(query: String, completion: @escaping ([Results]?) -> Void)
}

protocol ProtocolInteractorToPresenterSearch: AnyObject
{
  
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol ProtocolPresenterToRouterSearch
{
  static func createModule() -> UIViewController?
  func pushToOpenList(view: ProtocolPresenterToViewSearch?, with listName: String, listKey: Int, editable: Bool)
}

