//
//  PopulateListProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol ProtocolViewToPresenterPopulateList
{
  //Setting Up View
  func viewDidLoad(_ listName: String, listKey: Int, firstOpen: Bool)
  func initInteractor()
  
  //Setting View Table
  func numberOfRowsInSection() -> Int
  func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
  
  //Navigation to Other Screens
  func pushToEditText(itemKey: Int, newText: String)
  func addNewTask(text: String)
  
  //Misc Functions to Populate View
  func getListName() -> String
  func changeListTitle(newTitle: String) -> Bool
  func allowEditing() -> Bool
  func isFirstOpen() -> Bool
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol ProtocolPresenterToViewPopulateList: AnyObject
{
  //Function to Open List Should be here and implemented on the backend
  func setRestTitle(_ newTitle: String)
  
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol ProtocolPresenterToInteractorPopulateList: AnyObject
{
  func setPresenter(presenter: ProtocolInteractorToPresenterPopulateList)
  
  func getList(listKey: Int)
  func changeListTitle(listKey: Int, newTitle: String, completion: @escaping ((Bool) -> Void))
  func allowEditing(listKey: Int)
  func changeItemStatus(itemKey: Int, newStatus: Bool)
  func changeItemText(itemKey: Int, newText: String)
  func newListItem(listKey: Int, text: String)
  func deleteListItem(listKey: Int, itemKey: Int) -> Bool
}

protocol ProtocolInteractorToPresenterPopulateList: AnyObject
{
  func setList(_ with: List?)
  func setEditingPermission(_ with: Bool)
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol ProtocolPresenterToRouterPopulateList
{
  static func createModule(with listName: String, listKey: Int, editable: Bool) -> UIViewController?
}

