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
        groupCount = interactor?.getGroupCount() ?? 0
        groups = interactor?.getGroups() ?? nil
        freeLists = interactor?.getGroupFreeListTitles()
        
        if freeLists?.isEmpty == false
        {
            groupCount += 1
        }
        
        //Handling Errors with erronous return
        if groupCount <= Constants.errorFetchCode
        {
            Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
        }
        if groups == nil
        {
            Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
        }
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
        
        if section == 0 && !freeLists!.isEmpty
        {
            //print(freeLists!.count)
            return freeLists!.count
        }
        else if section == 0 && freeLists!.isEmpty
        {
            //print(groups?[section].lists?.count)
            return groups?[section].lists?.count ?? 0
        }
        //print(groups?[section - 1].lists?.count)
        return groups?[section - 1].lists?.count ?? 0
    }
    
    //Setting Title For Section
    func tableView(titleForHeaderInSection section: Int) -> String? {

        if section == 0 && !freeLists!.isEmpty
        {
            return ""
        }
        else if section == 0 && freeLists!.isEmpty
        {
            //print(groups?[section].name)
            return groups?[section].name
        }
        //print(groups?[section - 1].name)
        return groups?[section - 1].name
    }
    
    //Setting View For Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "sectionHeader")! as! SectionHeader
        if section == 0 && !freeLists!.isEmpty
        {
            return nil
        }
        else if section == 0 && freeLists!.isEmpty
        {
            sectionHeader.setupCell(groupKey: Int((groups?[section].groupKey)!), groupName: (groups?[section].name)!, section: section, reference: self)
        }
        else
        {
            sectionHeader.setupCell(groupKey: Int((groups?[section - 1].groupKey)!), groupName: (groups?[section - 1].name)!, section: section, reference: self)
        }
        
        return sectionHeader
    }
    
    //Setting up the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.labels.optionalListCell, for: indexPath) as? OptionalListCell {
            
            let x: Group?
            
            if indexPath.section == 0 && !freeLists!.isEmpty
            {
                let keys = Array(freeLists!.keys)
                
                let listKey = keys[indexPath.row]
                let title = freeLists![keys[indexPath.row]]
                let count = interactor?.getListActiveCount(listKey: keys[indexPath.row])
                //print(listKey)
                //print(title)
                //print(count)
                cell.setupCell(listKey: listKey, text: title!, count: Utilities.convertToString(count!))
                return cell
            }
            else if indexPath.section == 0 && freeLists!.isEmpty
            {
                x = groups?[indexPath.section]
            }
            else
            {
                x = groups?[indexPath.section - 1]
            }
            
            //Get Title and Count of List
            
            x?.setListsArray()
            
            let listKey = Int((x?.listsArray[indexPath.row].listKey)!)
            let title = x?.listsArray[indexPath.row].name
            let count = Int((x?.listsArray[indexPath.row].activeTaskCount)!)
            //print(listKey)
            //print(title)
            //print(count)
            cell.setupCell(listKey: listKey, text: title!, count: Utilities.convertToString(count))
            return cell
        }
        return UITableViewCell()
    }
    
    //Set Section Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            print(0)
            return 0.0
        }
        //print(UITableView.automaticDimension)
        return UITableView.automaticDimension
    }
    
    
    //Delete swiped row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            tableView.beginUpdates()
            
            let cell = tableView.cellForRow(at: indexPath) as! OptionalListCell
            let key = cell.getListKey()
            
            if interactor?.deleteList(listKey: key) == false
            {
                print("In PopulateMenuPresenter >> DeleteSwipedRow >> Failed to Delete List")
                return
            }
            
            print(freeLists?.count as Any)
            freeLists?[key] = nil
            print(freeLists?.count as Any)
            
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
        let x: Bool
        if tableView(numberOfRowsInSection: section) > 0
        {
            x = false
        }
        else
        {
            x = true
        }
        viewController?.groupStatus(isEmpty: x, groupKey: groupKey, groupName: groupName, reference: self)
        view?.presentGroupOptions(viewController: viewController!)
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
        let set = interactor?.createList(listName: Utilities.newList())
        let key = set?.0
        let name = set?.1
        
        //Add List to free list
        freeLists![key!] = name
        
        //Refresh Table View
        view?.showActivity()
        
        //Open said new list
        router?.pushToOpenList(view: view, with: name!, listKey: key!, editable: true)
    }
    
    func newGroupPrompt(groupKey: Int) {
        let vc = router?.createGroupPrompt()
        vc?.setGroupKey(groupKey: groupKey)
        vc?.setDelegate(self)
        view?.presentGroupPrompt(viewController: vc!)
    }

}

//MARK: MISC Functionalities
extension PopulateMenuPresenter
{
    func createNewGroup(groupName: String) -> Int {
        //Interactor Functionality
        let x = interactor?.createGroup(groupName: groupName)
        
        if x == nil
        {
            Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[5])
            return -1
        }
        
        self.viewDidLoad()
        return x!
    }

    func getActiveListCount(listKey: Int) -> Int
    {
        return interactor?.getListActiveCount(listKey: listKey) ?? 0
    }
    
    func getStaticListTitles() -> [Int : String] {
        return interactor?.getPermanentListTitles() ?? [:]
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
            print("In PopulateMenuPresenter >> addDeleteList >> View Not Generated")
            return
        }
        newView?.setDelegate(self)
        newView?.setGroupKey(groupKey: groupKey)
        view?.presentGroupPrompt(viewController: newView!)
    }
    
    func renameGroup(groupKey: Int, groupName: String) -> Bool
    {
        let x = interactor?.renameGroup(groupKey: groupKey, newName: groupName)
        if x == nil || x == false
        {
            return false
        }
        groups = interactor?.getGroups() ?? nil
        if groups == nil
        {
            Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[4])
        }
        view?.showActivity()
        return true
    }
    
    func deleteGroup(groupKey: Int)
    {
        if interactor?.deleteGroup(groupKey: groupKey) == true
        {
            viewDidLoad()
            view?.showActivity()
            return
        }
        print("In PopulateMenuPresenter >> deleteGroup >> Unexpected Error Occured")
    }
    
    func ungroup(groupKey: Int)
    {
        if interactor?.ungroup(groupKey: groupKey) == true
        {
            viewDidLoad()
            view?.showActivity()
            return
        }
        print("In PopulateMenuPresenter >> ungroup >> Unexpected Error Occured")
    }
}

extension PopulateMenuPresenter: GroupPromptProtocol
{
    func setRows(groupKey: Int) -> Int {
        var total = freeLists!.count + 0
        
        if groups != nil
        {
            for i in groups!
            {
                if i.groupKey == groupKey
                {
                    total += i.listsArray.count
                }
            }
        }
        return total
    }

    
    func setCell(_ cell: Listing, indexPath: IndexPath, rowCount: Int, groupKey: Int) {
        //Setting Up Cell - from Lists and groups
        
        if (freeLists?.count)! - indexPath.row > 0
        {
            let keys = Array(freeLists!.keys)
            let names = Array(freeLists!.values)
            cell.setupCell(listKey: keys[indexPath.row], listName: names[indexPath.row], openedGroupKey: groupKey, isAdded: false, reference: self)
        }
        else
        {
            for i in groups!
            {
                if i.groupKey == groupKey
                {
                    i.setListsArray()
                    let index = indexPath.row - freeLists!.count
                    let list = i.listsArray[index]
                    cell.setupCell(listKey: Int(list.listKey), listName: list.name!, openedGroupKey: groupKey, isAdded: true, reference: self)
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
            print("In PopulateMenuPresenter >> Extension: Listing Cell Protocol >> addListTogroup >> ERROR")
            return
        }
        viewDidLoad()
        view?.showActivity()
    }
    
    func removeListFromGroup(listKey: Int, groupKey: Int) {
        if interactor?.removeListFromGroup(listKey: listKey, groupKey: groupKey) == false
        {
            print("In PopulateMenuPresenter >> Extension: Listing Cell Protocol >> addListTogroup >> ERROR")
            return
        }
        viewDidLoad()
        view?.showActivity()
    }
}
