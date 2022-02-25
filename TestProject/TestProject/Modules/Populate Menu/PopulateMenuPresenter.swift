//
//  PopulateMenuPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

class PopulateMenuPresenter: ProtocolViewToPresenterPopulateMenu, ProtocolInteractorToPresenterPopulateMenu
{
  //Data Members
  private var view: ProtocolPresenterToViewPopulateMenu?
  private var interactor: ProtocolPresenterToInteractorPopulateMenu?
  private var router: ProtocolPresenterToRouterPopulateMenu?
  
  private var groupCount: Int
  private var groups: [Group]?
  private var freeLists: [Int: String]?
  private var staticListTitles = [Int : String]()
  private var activeTaskCount = [Int: Int]()
  
  private var collapsedSections = Set<Int>()
  
  //End of Data Members
  
  init(view: ProtocolPresenterToViewPopulateMenu?, interactor: ProtocolPresenterToInteractorPopulateMenu?, router: ProtocolPresenterToRouterPopulateMenu?)
  {
    //Setting Up Data Members
    self.view = view
    self.interactor = interactor
    self.router = router
    
    //RECHECK THIS
    groupCount = 0
    groups = nil
  }
  
  func initInteractor() {
    interactor?.setPresenter(presenter: self)
  }
  
  //Presenter Loading up required Data
  func viewDidLoad() {
    
    //Setting Up Table Data
    interactor?.getGroupCount(completion: { result in
      self.groupCount = result
      if self.groupCount <= Constants.errorFetchCode
      {
        Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
      }
    })
    
    interactor?.getGroups(completion: { result in
      self.groups = result
      if self.groups == nil
      {
        Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
      }
    })
    
    interactor?.getGroupFreeListTitles(completion: { result in
      self.freeLists = result
      if self.freeLists?.isEmpty == false
      {
        self.groupCount += 1
      }
    })
  }
}


//MARK: Table Related Functionalities
extension PopulateMenuPresenter
{
  //Set Number of Sections
  func numberOfSections() -> Int {
    //print(groupCount)
    return groupCount
  }
  
  //Set Rows in a Section
  func tableView(numberOfRowsInSection section: Int) -> Int {
    
    if collapsedSections.contains(section)
    {
      return 0
    }
    
    if section == 0 && !(freeLists?.isEmpty ?? false)
    {
      guard let count = freeLists?.count else {return Constants.errorFetchCode}
      return count
    }
    else if section == 0 && (freeLists?.isEmpty ?? false)
    {
      return groups?[section].lists?.count ?? 0
    }
    return groups?[section - 1].lists?.count ?? 0
  }
  
  //Setting Title For Section
  func tableView(titleForHeaderInSection section: Int) -> String? {
    
    if section == 0 && !(freeLists?.isEmpty ?? false)
    {
      return ""
    }
    else if section == 0 && (freeLists?.isEmpty ?? false)
    {
      return groups?[section].name
    }
    return groups?[section - 1].name
  }
  
  //Setting View For Section
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  {
    let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "sectionHeader") as! SectionHeader
    if section == 0 && !(freeLists?.isEmpty ?? false)
    {
      return nil
    }
    else if section == 0 && (freeLists?.isEmpty ?? false)
    {
      sectionHeader.setupCell(groupKey: Int((groups?[section].groupKey ?? Int64(Constants.newGroupKey))), groupName: (groups?[section].name ?? Constants.emptyString), section: section, reference: self)
    }
    else
    {
      sectionHeader.setupCell(groupKey: Int((groups?[section - 1].groupKey) ?? Int64(Constants.newGroupKey)), groupName: (groups?[section - 1].name) ?? Constants.emptyString, section: section, reference: self)
    }
    
    return sectionHeader
  }
  
  //Setting up the cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.Labels.optionalListCell, for: indexPath) as? OptionalListCell {
      
      let tempGroup: Group?
      
      if indexPath.section == 0 && !(freeLists?.isEmpty ?? false)
      {
        let keys = Array(freeLists?.keys ?? [:].keys)
        
        let listKey = keys[indexPath.row]
        let title = freeLists?[keys[indexPath.row]]
        
        interactor?.getListActiveCount(listKey: listKey, completion: { count in
          self.activeTaskCount[listKey] = count
        })
        
        let count = activeTaskCount[listKey]
        cell.setupCell(listKey: listKey, text: title ?? Constants.emptyString, count: Utilities.convertToString(count ?? 0))
        return cell
      }
      else if indexPath.section == 0 && (freeLists?.isEmpty ?? false)
      {
        tempGroup = groups?[indexPath.section]
      }
      else
      {
        tempGroup = groups?[indexPath.section - 1]
      }
      
      //Get Title and Count of List
      
      let tempList = tempGroup?.getListsArray()
      
      let listKey = Int((tempList?[indexPath.row].listKey ?? -1))
      let title = tempList?[indexPath.row].name
      interactor?.getListActiveCount(listKey: listKey, completion: { result in
        self.activeTaskCount[listKey] = result
      })
      let count = activeTaskCount[listKey] ?? 0
      cell.setupCell(listKey: listKey, text: title ?? Constants.emptyString, count: Utilities.convertToString(count))
      return cell
    }
    return UITableViewCell()
  }
  
  //Set Section Height
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  {
    if section == 0
    {
      return 0.0
    }
    return UITableView.automaticDimension
  }
  
  
  //Delete swiped row
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete
    {
      tableView.beginUpdates()
      
      let cell = tableView.cellForRow(at: indexPath) as! OptionalListCell
      groups = interactor?.deleteList(listKey: cell.getListKey())
      
      tableView.deleteRows(at: [indexPath], with: .middle)
      tableView.endUpdates()
    }
  }
}

//MARK: CELL RELATED FUNCTIONALITIES HERE
extension PopulateMenuPresenter: SectionHeaderProtocols
{
  func didPressOptions(section: Int, groupKey: Int, groupName: String) {
    let viewController = router?.createGroupOptions()
    let result: Bool
    if tableView(numberOfRowsInSection: section) > 0
    {
      result = false
    }
    else
    {
      result = true
    }
    viewController?.groupStatus(isEmpty: result, groupKey: groupKey, groupName: groupName, reference: self)
    view?.presentGroupOptions(viewController: viewController ?? GroupOptions())
  }
  
  func didPressCollapser(section: Int, isCollapsing: Bool) {
    
    if isCollapsing == false
    {
      collapsedSections.remove(section)
      
      let rows = tableView(numberOfRowsInSection: section)
      var indexPaths = [IndexPath]()
      
      if rows > 0
      {
        for i in 0...(rows-1)
        {
          let x = IndexPath(row: i, section: section)
          indexPaths.append(x)
        }
      }
      
      view?.openSection(indexPath: indexPaths)
    }
    else
    {
      let rows = tableView(numberOfRowsInSection: section)
      collapsedSections.insert(section)
      var indexPaths = [IndexPath]()
      
      if rows > 0
      {
        for i in 0...(rows-1)
        {
          let x = IndexPath(row: i, section: section)
          indexPaths.append(x)
        }
      }
      view?.closeSection(indexPath: indexPaths)
    }
  }
  
  
}

//MARK: Navigational Functionalities
extension PopulateMenuPresenter
{
  func pushToOpenList(listKey: Int) {
    let name = (interactor?.getListTitle(listKey: listKey)) ?? Constants.emptyString
    router?.pushToOpenList(view: view, with: name)
  }
  func pushToSearch() {
    router?.pushToSearch(view: view)
  }
  
  func pushToProfile() {
    router?.pushToProfile(view: view)
  }
  
  func pushToAddNewList() {
    //Create New List
    var name = Utilities.newList()
    var count = 1
    var result = interactor?.createList(listName: name) ?? -1
    
    while result  < 0
    {
      name = Utilities.newList() + "(" + String(count) + ")"
      result = interactor?.createList(listName: name) ?? -1
      count += 1
    }
    
    router?.pushToOpenList(view: view, with: name, editable: true)
  }
  
  //Create a Function to generate and set group prompt
  
}

//MARK: MISC Functionalities
extension PopulateMenuPresenter
{
  func createNewGroup(groupName: String) {
    //Interactor Functionality
    interactor?.createGroup(groupName: groupName, completion: { result in
      if result == false
      {
        Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[5])
        return
      }
      
      self.viewDidLoad()
    })
  }
  
  func setActiveListCount(listKey: Int)
  {
    interactor?.getListActiveCount(listKey: listKey, completion: { result in
      self.view?.setCount(listKey: listKey, count: result)
    })
  }
  
  func setStaticListTitles(){
    interactor?.getPermanentListTitles(completion: { result in
      self.staticListTitles = result
      self.view?.setStaticListTitles()
    })
  }
  
  func getStaticListTitles() -> [Int:String]{
    return staticListTitles
  }
}


//MARK: Group Option Functionalities
extension PopulateMenuPresenter: GroupOptionsProtocols
{
  
  func addDeleteLists(groupKey: Int) {
    //Get this done using a function
    let newView = router?.createGroupPrompt()
    
    if newView == nil
    {
      LoggingSystemFlow.printLog("In PopulateMenuPresenter >> addDeleteList >> View Not Generated")
      return
    }
    newView?.setDelegate(self)
    newView?.setGroupKey(groupKey: groupKey)
    view?.presentGroupPrompt(viewController: newView ?? GroupPrompt())
  }
  
  func renameGroup(groupKey: Int, groupName: String)
  {
    interactor?.renameGroup(groupKey: groupKey, newName: groupName, completion: { result in
      if result
      {
        self.interactor?.getGroups(completion: { groupResult in
          self.groups = groupResult
          
          if self.groups == nil
          {
            Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
          }
          self.view?.showActivity()
        })
      }
    })
  }
  
  func deleteGroup(groupKey: Int)
  {
    if interactor?.deleteGroup(groupKey: groupKey) == true
    {
      viewDidLoad()
      view?.showActivity()
      return
    }
    LoggingSystemFlow.printLog("In PopulateMenuPresenter >> deleteGroup >> Unexpected Error Occured")
  }
  
  func ungroup(groupKey: Int)
  {
    if interactor?.ungroup(groupKey: groupKey) == true
    {
      viewDidLoad()
      view?.showActivity()
      return
    }
    LoggingSystemFlow.printLog("In PopulateMenuPresenter >> ungroup >> Unexpected Error Occured")
  }
}

extension PopulateMenuPresenter: GroupPromptProtocol
{
  func setRows(groupKey: Int) -> Int {
    var total = freeLists?.count ?? 0 + 0
    
    if groups != nil
    {
      for i in groups ?? []
      {
        if i.groupKey == groupKey
        {
          total += (i.getListsArray()).count
        }
      }
    }
    return total
  }
  
  
  func setCell(_ cell: Listing, indexPath: IndexPath, rowCount: Int, groupKey: Int) {
    //Setting Up Cell - from Lists and groups
    
    guard let count = freeLists?.count else {return}
    
    
    if count - indexPath.row > 0
    {
      let keys = Array(freeLists?.keys ?? [:].keys)
      let names = Array(freeLists?.values ?? [:].values)
      cell.setupCell(listKey: keys[indexPath.row], listName: names[indexPath.row], openedGroupKey: groupKey, isAdded: false, reference: self)
    }
    else
    {
      guard let groups = self.groups else {return}
      
      for i in groups
      {
        if i.groupKey == groupKey
        {
          guard let count = freeLists?.count else {return}
          let index = indexPath.row - count
          let list = (i.getListsArray())[index]
          cell.setupCell(listKey: Int(list.listKey), listName: list.name ?? Constants.emptyString, openedGroupKey: groupKey, isAdded: true, reference: self)
          break
        }
        
      }
    }
  }
}

extension PopulateMenuPresenter: ListingCellProtocol
{
  func addListToGroup(listKey: Int, groupKey: Int) {
    if interactor?.addListToGroup(listKey: listKey, groupKey: groupKey) == false
    {
      LoggingSystemFlow.printLog("In PopulateMenuPresenter >> Extension: Listing Cell Protocol >> addListTogroup >> ERROR")
      return
    }
    viewDidLoad()
    view?.showActivity()
  }
  
  func removeListFromGroup(listKey: Int, groupKey: Int) {
    if interactor?.removeListFromGroup(listKey: listKey, groupKey: groupKey) == false
    {
      LoggingSystemFlow.printLog("In PopulateMenuPresenter >> Extension: Listing Cell Protocol >> addListTogroup >> ERROR")
      return
    }
    viewDidLoad()
    view?.showActivity()
  }
}
