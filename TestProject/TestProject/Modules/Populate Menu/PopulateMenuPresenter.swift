//
//  PopulateMenuPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

class PopulateMenuPresenter: ProtocolViewToPresenterPopulateMenu, ProtocolInteractorToPresenterPopulateMenu
{
  //MARK: DATA MEMBERS
  private var view: ProtocolPresenterToViewPopulateMenu?
  private var interactor: ProtocolPresenterToInteractorPopulateMenu?
  private var router: ProtocolPresenterToRouterPopulateMenu?
  
  private var groupCount: Int
  private var groups: [Group]?
  private var freeLists: [Int: String]?
  private var staticListTitles = [Int : String]()
  private var activeTaskCount = [Int: Int]()
  
  private var collapsedSections = Set<Int>()
  
  //END - DATA MEMBERS
  
  
  init(view: ProtocolPresenterToViewPopulateMenu?, interactor: ProtocolPresenterToInteractorPopulateMenu?, router: ProtocolPresenterToRouterPopulateMenu?)
  {
    //Setting Up Data Members
    self.view = view
    self.interactor = interactor
    self.router = router
    
    groupCount = 0
    groups = nil
  }
  
  func initInteractor() {
    interactor?.setPresenter(presenter: self)
  }
  
  //Presenter Loading up required Data
  func viewDidLoad() {
    
    //Reading Total Count of Groups
    interactor?.getGroupCount(completion: { result in
      self.groupCount = result
      if self.groupCount <= Constants.errorFetchCode
      {
        Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
      }
    })
   
    //Getting Group Data
    interactor?.getGroups(completion: { result in
      self.groups = result
      if self.groups == nil
      {
        Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
      }
    })
    
    //Getting Group Free Titles
    interactor?.getGroupFreeListTitles(completion: { result in
      self.freeLists = result
    })
  }
  
}


//MARK: Table Related Functionalities
extension PopulateMenuPresenter
{
  //Set Number of Sections
  func numberOfSections() -> Int {
    if freeLists?.isEmpty == false
    {
     return groupCount + 1
    }
    return groupCount
  }
  
  //Set Rows in a Section
  func tableView(numberOfRowsInSection section: Int) -> Int {
    if collapsedSections.contains(section)
    {
      return 0
    }
    
    var isFreeListEmpty: Bool = true
    var groupCount: Int = groups?.count ?? -1
    if freeLists?.isEmpty == nil || freeLists?.isEmpty == false
    {
      isFreeListEmpty = false
    }
    if groups?.count == nil || (groups?.count ?? -1) <= 0
    {
      groupCount = 0
    }
    
    
    if isFreeListEmpty
    {
      if groupCount > 0
      {
        //Groups exist but Free-Lists dont
        return (groups?[section].lists?.count ?? 0)
      }
      //ELSE CASE:
      ///Neither groups nor Free-Lists exist - Is unreachable because Section Count = 0
    }
    else
    {
      if groupCount > 0
      {
        //Groups and Free-Lists Exist
        if section == 0
        {
          //Populate Free-Lists
          return (freeLists?.count ?? 0)
        
        }
        else if section > 0
        {
          //Populate Groups
          let index = section - 1
          return (groups?[index].lists?.count ?? 0)
        }
      }
      else
      {
        //Free Lists exist but Groups dont
        return (freeLists?.count ?? 0)
      }
    }
    
    return 0
  }
  
  //Setting View For Section
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  {
    let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.UIDefaults.Labels.sectionHeader) as! NIBSectionHeader
    
    var isFreeListEmpty: Bool = true
    var groupCount: Int = groups?.count ?? -1
    if freeLists?.isEmpty == nil || freeLists?.isEmpty == false
    {
      isFreeListEmpty = false
    }
    if groups?.count == nil || (groups?.count ?? -1) <= 0
    {
      groupCount = 0
    }
    
    if isFreeListEmpty
    {
      if groupCount > 0
      {
        //Groups exist but Free-Lists dont
        sectionHeader.setupCell(groupKey: Int((groups?[section].groupKey ?? Int64(Constants.newGroupKey))), groupName: (groups?[section].name ?? Constants.emptyString), section: section, reference: self)
      }
      else
      {
        return nil
      }
      //ELSE CASE: -> Empty Table
      ///Neither groups nor Free-Lists exist - Is unreachable because Section Count = 0
    }
    else
    {
      if groupCount > 0
      {
        //Groups and Free-Lists Exist
        if section == 0
        {
          //Populate Free-Lists
          return nil
        
        }
        else if section > 0
        {
          //Populate Groups
          let index = section - 1
          sectionHeader.setupCell(groupKey: Int((groups?[index].groupKey) ?? Int64(Constants.newGroupKey)), groupName: (groups?[index].name) ?? Constants.emptyString, section: section, reference: self)
        }
      }
      else
      {
        //Free Lists exist but Groups dont
        return nil
      }
    }
    
    //let uiview = UIView(frame: sectionHeader.frame)
    //uiview.addSubview(sectionHeader)
    //return uiview
    return sectionHeader
  }
  
  //Setting up the cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.Labels.optionalListCell, for: indexPath) as? OptionalListCell {
      
      
      var isFreeListEmpty: Bool = true
      var groupCount: Int = groups?.count ?? -1
      if freeLists?.isEmpty == nil || freeLists?.isEmpty == false
      {
        isFreeListEmpty = false
      }
      if groups?.count == nil || (groups?.count ?? -1) <= 0
      {
        groupCount = 0
      }
      
      if isFreeListEmpty
      {
        if groupCount > 0
        {
          //Groups exist but Free-Lists dont
          let listArray = groups?[indexPath.section].getListsArray()
          let list = listArray?[indexPath.row]
          let listKey = Int((list?.listKey ?? Int64(Constants.newListKey)))
          
          interactor?.getListActiveCount(listKey: listKey, completion: { count in
            self.activeTaskCount[listKey] = count
          })
          
          let count = activeTaskCount[listKey]
          cell.setupCell(listKey: listKey, text: (list?.name ?? Constants.emptyString), count: Utilities.convertToString(count ?? 0))
          return cell
        }
        //ELSE CASE:
        ///Neither groups nor Free-Lists exist - Is unreachable because Section Count = 0
      }
      else
      {
        if groupCount > 0
        {
          //Groups and Free-Lists Exist
          if indexPath.section == 0
          {
            //Populate Free-Lists
            
            var keys = Array(freeLists?.keys ?? [:].keys)
            keys.sort()
            let listKey = keys[indexPath.row]
            let title = freeLists?[keys[indexPath.row]]
            
            interactor?.getListActiveCount(listKey: listKey, completion: { count in
              self.activeTaskCount[listKey] = count
            })
            
            let count = activeTaskCount[listKey]
            cell.setupCell(listKey: listKey, text: (title ?? Constants.emptyString), count: Utilities.convertToString(count ?? 0))
            return cell
          }
          else if indexPath.section > 0
          {
            //Populate Groups
            let index = indexPath.section - 1
            
            let listArray = groups?[index].getListsArray()
            let list = listArray?[indexPath.row]
            let listKey = Int((list?.listKey ?? Int64(Constants.newListKey)))
            
            interactor?.getListActiveCount(listKey: listKey, completion: { count in
              self.activeTaskCount[listKey] = count
            })
            
            let count = activeTaskCount[listKey]
            cell.setupCell(listKey: listKey, text: (list?.name ?? Constants.emptyString), count: Utilities.convertToString(count ?? 0))
            return cell
          }
        }
        else
        {
          //Free Lists exist but Groups dont
          var keys = Array(freeLists?.keys ?? [:].keys)
          keys.sort()
          let listKey = keys[indexPath.row]
          let title = freeLists?[keys[indexPath.row]]
          
          interactor?.getListActiveCount(listKey: listKey, completion: { count in
            self.activeTaskCount[listKey] = count
          })
          
          let count = activeTaskCount[listKey]
          cell.setupCell(listKey: listKey, text: (title ?? Constants.emptyString), count: Utilities.convertToString(count ?? 0))
          return cell
        }
      }
    }
    return UITableViewCell()
  }
  
  //Set Section Height
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  {
    if section == 0 && freeLists?.isEmpty == false
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
      
      let key = cell.getListKey()
      if interactor?.deleteList(listKey: key) == true
      {
        freeLists?[key] = nil
        activeTaskCount[key] = nil
      }
      
      if freeLists?.isEmpty == true
      {
        tableView.deleteSections(IndexSet(integer: 0), with: .top)
      }
      
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
        for row in 0...(rows-1)
        {
          let path = IndexPath(row: row, section: section)
          indexPaths.append(path)
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
        for row in 0...(rows-1)
        {
          let path = IndexPath(row: row, section: section)
          indexPaths.append(path)
        }
      }
      view?.closeSection(indexPath: indexPaths)
    }
  }
}

//MARK: Navigational Functionalities
extension PopulateMenuPresenter
{
  func pushToOpenList(listKey: Int, listName: String) {
    router?.pushToOpenList(view: view, with: listName, listKey: listKey)
  }
  func pushToSearch() {
    router?.pushToSearch(view: view)
  }
  func pushToProfile() {
    router?.pushToProfile(view: view)
  }
  
  func pushToAddNewList() {
    //Create New List
    
    interactor?.createList(listName: Constants.newListTitle, completion: { resultSet in
      let key = resultSet.0
      let name = resultSet.1
      //Add List to free list
      self.freeLists?[key] = name
      
      //Open said new list
      self.router?.pushToOpenList(view: self.view, with: name , listKey: key , editable: true)
    })
  }
  
  func newGroupPrompt(groupKey: Int) {
    let viewController = router?.createGroupPrompt()
    viewController?.setGroupKey(groupKey: groupKey)
    viewController?.setDelegate(self)
    view?.presentGroupPrompt(viewController: viewController ?? GroupPrompt())
  }
}

//MARK: MISC Functionalities
extension PopulateMenuPresenter
{
  func createNewGroup(groupName: String){
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
    })  }
  
  func setStaticListTitles(){
    interactor?.getPermanentListTitles(completion: { result in
      self.staticListTitles = result
      self.view?.setStaticListTitles()
    })
  }
  
  func getStaticListTitles() -> [Int:String]{
    return staticListTitles
  }
  
  func getNewGroupKey() -> Int {
    var newKey = Constants.newGroupKey
    
    for group in groups ?? []
    {
      if newKey < Int(group.groupKey)
      {
        newKey = Int(group.groupKey)
      }
    }
    return newKey
  }
}


//MARK: Group Option Functionalities
extension PopulateMenuPresenter: GroupOptionsProtocols
{
  
  func addDeleteLists(groupKey: Int) {
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
  
  func renameGroup(groupKey: Int, groupName: String) -> Bool{
    ((interactor?.renameGroup(groupKey: groupKey, newName: groupName, completion: { result in
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
    })) != nil)
  }
  
  func deleteGroup(groupKey: Int){
    if interactor?.deleteGroup(groupKey: groupKey) == true
    {
      viewDidLoad()
      view?.showActivity()
      return
    }
    LoggingSystemFlow.printLog("In PopulateMenuPresenter >> deleteGroup >> Unexpected Error Occured")
  }
  
  func ungroup(groupKey: Int){
    if interactor?.ungroup(groupKey: groupKey) == true
    {
      viewDidLoad()
      view?.showActivity()
      return
    }
    LoggingSystemFlow.printLog("In PopulateMenuPresenter >> ungroup >> Unexpected Error Occured")
  }
}

//MARK: Group Prompt Functionalities
extension PopulateMenuPresenter: GroupPromptProtocol
{
  func setRows(groupKey: Int) -> Int {
    var total = (freeLists?.count ?? 0) + 0
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
    //Setting Up Cell - from Lists and group
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


//MARK: Listing Cell Functionalities
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
