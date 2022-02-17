//
//  PopulateMenuProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol ProtocolViewToPresenterPopulateMenu
{    
  //Setting Up
  func viewDidLoad()
  func initInteractor()
  
  //Navigation to Other Screens
  func pushToSearch()
  func pushToProfile()
  func pushToAddNewList()
  func pushToOpenList(listKey: Int, listName: String)
  func createNewGroup(groupName: String)
  func newGroupPrompt(groupKey: Int)
  
  //Setting View Table
  func numberOfSections() -> Int
  func tableView(numberOfRowsInSection section: Int) -> Int
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  
  
  //Misc Functions to Populate View
  func setActiveListCount(listKey: Int)
  func setStaticListTitles()
  func getStaticListTitles() -> [Int:String]
  func getNewGroupKey() -> Int
  
}


//MARK: - View Output
//To Pass information from Presenter to View
protocol ProtocolPresenterToViewPopulateMenu: AnyObject
{
  //Function to Open List Should be here and implemented on the backend
  func setCount(listKey: Int, count: Int)
  func setStaticListTitles()
  func showActivity()
  func closeSection(indexPath: [IndexPath])
  func openSection(indexPath: [IndexPath])
  func presentGroupOptions(viewController: GroupOptions)
  func presentGroupPrompt(viewController: GroupPrompt)
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol ProtocolPresenterToInteractorPopulateMenu: AnyObject
{
  func setPresenter(presenter: ProtocolInteractorToPresenterPopulateMenu?)
  
  //MARK: Functionality (CRUD)
  
  //Create
  func createGroup(groupName: String, completion: @escaping ((Bool) -> Void))
  func createList(listName: String, completion: @escaping (((Int, String)) -> Void))
  func addListToGroup(listKey: Int, groupKey: Int) -> Bool
  
  //Read
  // MIGHT NOT NEED THIS -> RECHECK : func getListTitle(listKey: Int) -> String 
  func getGroups(completion: @escaping (([Group]?) -> Void))
  func getPermanentListTitles(completion: @escaping (([Int : String]) -> Void))
  func getListActiveCount(listKey: Int, completion: @escaping ((Int) -> Void))
  func getGroupFreeListTitles(completion: @escaping (([Int : String]) -> Void))
  func getGroupCount(completion: @escaping ((Int) -> Void))
  func getGroupTitles(groupKey: Int, completion: @escaping (([Int : String]) -> Void))
  
  //Update
  func renameList(listKey: Int, newName: String) -> Bool
  func renameGroup(groupKey: Int, newName: String, completion: @escaping ((Bool) -> Void))
  func ungroup(groupKey: Int) -> Bool
  
  //Delete
  func deleteGroup(groupKey: Int) -> Bool
  //Recheck this too
  func deleteList(listKey: Int) -> Bool
  func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool
}


protocol ProtocolInteractorToPresenterPopulateMenu: AnyObject
{
  
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol ProtocolPresenterToRouterPopulateMenu
{
  static func createModule() -> UINavigationController?
  
  //Navigation Controls
  func pushToProfile(view: ProtocolPresenterToViewPopulateMenu?)
  func pushToSearch(view: ProtocolPresenterToViewPopulateMenu?)
  func pushToOpenList(view: ProtocolPresenterToViewPopulateMenu?, with listName: String, listKey: Int, delegate: ListToMenuUpdate?)
  func pushToOpenList(view: ProtocolPresenterToViewPopulateMenu?, with listName: String, listKey: Int, editable: Bool, delegate: ListToMenuUpdate?)
  
  //Creation Controls
  func createGroupOptions() -> GroupOptions
  func createGroupPrompt() -> GroupPrompt
}

protocol ListToMenuUpdate: AnyObject
{
  func updateListName(listKey:Int, newName: String)
}
