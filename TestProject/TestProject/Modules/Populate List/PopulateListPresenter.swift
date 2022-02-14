//
//  PopulateListPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateListPresenter: ProtocolViewToPresenterPopulateList, ProtocolInteractorToPresenterPopulateList
{
  //MARK: DATA MEMBERS
  
  private var view: ProtocolPresenterToViewPopulateList?
  private var interactor: ProtocolPresenterToInteractorPopulateList?
  private var router: ProtocolPresenterToRouterPopulateList?
  
  private var listName: String?
  private var listKey: Int?
  private var list: List?
  private var firstOpen: Bool?
  
  //END OF DATA MEMBERS
  
  init(view: ProtocolPresenterToViewPopulateList?, interactor: ProtocolPresenterToInteractorPopulateList?, router: ProtocolPresenterToRouterPopulateList?)
  {
    //Setting Up Data Members
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  func initInteractor() {
    interactor?.setPresenter(presenter: self)
  }
  
  //Setting up screen
  func viewDidLoad(_ listName: String, listKey: Int, firstOpen: Bool) {
    //Presenter is asking to Interact to load new data
    self.listName = listName
    self.listKey = listKey
    list = interactor?.getList(listKey: listKey) //THIS WILL HAVE TO BE REFACTORED
    self.firstOpen = firstOpen
  }

  func getListName() -> String{
    return listName ?? Constants.newListTitle
  }

  func allowEditing() -> Bool {
    let result = interactor?.allowEditing(listKey: listKey!)
    if result == nil
    {
      return false
    }
    return result!
  }
  
  func isFirstOpen() -> Bool {
    return firstOpen ?? false
  }
}

//MARK: Use Case Functionalities
extension PopulateListPresenter
{
  func changeListTitle(newTitle: String) -> Bool
  {
    let result = interactor?.changeListTitle(listKey: listKey ?? Constants.newListKey, newTitle: newTitle)
    if result == nil
    {
      return false
    }
    
    return result ?? false
  }
}

//MARK: Navigational Functionalities
extension PopulateListPresenter
{
  func pushToEditText(itemKey: Int, newText: String) {
    interactor?.changeItemText(itemKey: itemKey, newText: newText)
    list = interactor?.getList(listKey: listKey ?? Constants.newListKey)
  }
}


//MARK: Table Related Functions
extension PopulateListPresenter
{
  func numberOfRowsInSection() -> Int {
    let listItemsArray = list?.getListItemsArray()
    return listItemsArray?.count ?? 0
  }
  
  func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.Labels.listItemCell, for: indexPath) as? ListItemCell {
      let listItemsArray = list?.getListItemsArray()
      
      cell.setupCell(itemKey: Int(listItemsArray?[indexPath.row].itemKey ?? Int64(Constants.newListItemKey)), text: listItemsArray?[indexPath.row].text ?? Constants.newListItemTitle, status: listItemsArray?[indexPath.row].done ?? false, reference: self)
      return cell
    }
    return UITableViewCell()
  }
  
  //Delete swiped row
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete
    {
      tableView.beginUpdates()
      
      let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
      let key = cell.getItemKey()
      
      if interactor?.deleteListItem(listKey: listKey!, itemKey: key) == false
      {
        LoggingSystemFlow.printLog("In PopulateListPresenter >> DeleteSwipedRow >> Failed to Delete List Item")
        return
      }
      
      list = interactor?.getList(listKey: listKey ?? Constants.newListKey)
      
      tableView.deleteRows(at: [indexPath], with: .middle)
      tableView.endUpdates()
    }
  }
  
  
  func addNewTask(text: String) {
    interactor?.newListItem(listKey: listKey ?? Constants.newListKey, text: text)
    list = interactor?.getList(listKey: listKey ?? Constants.newListKey)
  }
}


//MARK: List Item Cell Functionalities
extension PopulateListPresenter: ListItemCellProtocols
{
  func didTapChecked(itemKey: Int, newStatus: Bool) {
    interactor?.changeItemStatus(itemKey: itemKey, newStatus: newStatus)
    
    //Reflect this in MenuVC in count
    
  }
}
