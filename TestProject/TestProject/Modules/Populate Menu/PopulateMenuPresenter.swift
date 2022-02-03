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
            groups = interactor?.deleteList(listKey: cell.getListKey())
            
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
}

//MARK: CELL RELATED FUNCTIONALITIES HERE
extension PopulateMenuPresenter: SectionHeaderProtocols
{
    func didPressOptions() {
        print("In PopulateMenu Presenter >> didPressOptions")
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
        let name = (interactor?.getListTitle(listKey: listKey))!
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
        var result = interactor?.createList(listName: name)
        
        while result! < 0
        {
            name = Utilities.newList() + "(" + String(count) + ")"
            result = interactor?.createList(listName: name)
            count += 1
        }
        
        router?.pushToOpenList(view: view, with: name, editable: true)
    }

}

//MARK: MISC Functionalities
extension PopulateMenuPresenter
{
    func createNewGroup(groupName: String) {
        //Interactor Functionality
        let x = interactor?.createGroup(groupName: groupName)
        
        if x == false
        {
            Utilities.popAnError(self.view as! UIViewController, Constants.errorCodes[5])
            return
        }
        
        self.viewDidLoad()
    }

    func getActiveListCount(listKey: Int) -> Int
    {
        return interactor?.getListActiveCount(listKey: listKey) ?? 0
    }
    
    func getStaticListTitles() -> [Int : String] {
        return interactor?.getPermanentListTitles() ?? [:]
    }
}
