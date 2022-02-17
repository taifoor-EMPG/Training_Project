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
  
  private weak var menuDelegate: ListToMenuUpdate?
  
  private var listName: String?
  private var listKey: Int?
  private var list: List?
  private var firstOpen = false
  private var isPermanent = true
  private var colored = false
  
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
  
  func setDelegate(delegate: ListToMenuUpdate?) {
    menuDelegate = delegate
  }
  
  //Setting up screen
  func viewDidLoad(_ listName: String, listKey: Int, firstOpen: Bool) {
    //Presenter is asking to Interact to load new data
    self.listName = listName
    self.listKey = listKey
    interactor?.getList(listKey: listKey)
    self.firstOpen = firstOpen
    interactor?.allowEditing(listKey: listKey)
    
    if list?.color != nil || list?.color != "default"
    {
      colored = true
      view?.colorScreen(UIColor(named: list?.color ?? Constants.emptyString) ?? UIColor.systemBackground)
    }
  }

  func setList(_ with: List?)
  {
    list = with
  }
  
  func setEditingPermission(_ with: Bool)
  {
    isPermanent = with
  }
  
  func getListName() -> String{
    return listName ?? Constants.newListTitle
  }

  func allowEditing() -> Bool {
    return !isPermanent
  }
  
  func isFirstOpen() -> Bool {
    return firstOpen
  }
}

//MARK: Use Case Functionalities
extension PopulateListPresenter
{
  func changeListTitle(newTitle: String) -> Bool
  {
    ((interactor?.changeListTitle(listKey: listKey ?? Constants.newListKey, newTitle: newTitle, completion: { result in
      if result
      {
        self.interactor?.getList(listKey: self.listKey ?? Constants.newListKey)
        self.view?.resetTitle(newTitle)
        self.menuDelegate?.updateListName(listKey: self.listKey ?? Constants.newListKey, newName: newTitle)
      }
    })) != nil)
  }
  
  func getWallpapers() -> [String] {
    let manager = WallPaperManager()
    return manager.getWallpaperList()
  }
  
  func setColor(_ color: String) {
    interactor?.setListColor(listKey: listKey ?? Constants.newListKey, color: color)
  }
  
  func addNewTask(text: String) {
    interactor?.newListItem(listKey: listKey ?? Constants.newListKey, text: text)
    interactor?.getList(listKey: listKey ?? Constants.newListKey)
  }
  
  func updateCount(_ views: [UIViewController])
  {
    if (listKey ?? Constants.newListKey) >= 0 && (listKey ?? Constants.newListKey) < Constants.staticListCount
    {
      for view in views
      {
        if view.isKind(of: MenuVC.self)
        {
          let menuView = view as! MenuVC
          
          let items = list?.getListItemsArray()
          var count = 0
          for item in items ?? []
          {
            if item.done == false
            {
              count += 1
            }
          }
          menuView.setCount(listKey: listKey ?? Constants.newListKey, count: count)
        }
      }
    }
  }
}

//MARK: Navigational Functionalities
extension PopulateListPresenter
{
  func pushToEditText(itemKey: Int, newText: String) {
    interactor?.changeItemText(itemKey: itemKey, newText: newText)
    interactor?.getList(listKey: listKey ?? Constants.newListKey)
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
      
      if colored
      {
        cell.setBackgroundColor(UIColor(named: list?.color ?? "Col_Default") ?? .systemBackground)
      }
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
      
      interactor?.getList(listKey: listKey ?? Constants.newListKey)
      
      tableView.deleteRows(at: [indexPath], with: .middle)
      tableView.endUpdates()
    }
  }
}


//MARK: List Item Cell Functionalities
extension PopulateListPresenter: ListItemCellProtocols
{
  func didTapChecked(itemKey: Int, newStatus: Bool) {
    interactor?.changeItemStatus(itemKey: itemKey, newStatus: newStatus)
  }
}
