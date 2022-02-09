//
//  PopulateListPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateListPresenter: ProtocolViewToPresenterPopulateList, ProtocolInteractorToPresenterPopulateList
{
    //DATA MEMBERS
    
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
        list = interactor?.getList(listKey: listKey)
        list?.setListsArray()
        self.firstOpen = firstOpen
    }
    
    
    func pushToEditText(itemKey: Int, newText: String) {
        interactor?.changeItemText(itemKey: itemKey, newText: newText)
        list = interactor?.getList(listKey: listKey!)
        list?.setListsArray()
    }
    
    func getListName() -> String
    {
        return listName!
    }
    
    func changeListTitle(newTitle: String) -> Bool
    {
        let result = interactor?.changeListTitle(listKey: listKey!, newTitle: newTitle)
        if result == nil
        {
            return false
        }
        
        return result!
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
        return firstOpen!
    }
}


//MARK: Table Related Functions
extension PopulateListPresenter
{
    func numberOfRowsInSection() -> Int {
        return list?.listsItemsArray.count ?? 0
    }
    
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.labels.listItemCell, for: indexPath) as? ListItemCell {
            let listItemsArray = list?.listsItemsArray
            
            cell.setupCell(itemKey: Int(listItemsArray![indexPath.row].itemKey), text: listItemsArray![indexPath.row].text!, status: listItemsArray![indexPath.row].done, reference: self)
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
                print("In PopulateListresenter >> DeleteSwipedRow >> Failed to Delete List Item")
                return
            }
            
            list = interactor?.getList(listKey: listKey!)
            list?.setListsArray()
            
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
    
    
    func addNewTask(text: String) {
        interactor?.newListItem(listKey: listKey!, text: text)
        list = interactor?.getList(listKey: listKey!)
        list?.setListsArray()
    }
}


//To Provide Functionality to List Item Cell
extension PopulateListPresenter: ListItemCellProtocols
{
    func didTapChecked(itemKey: Int, newStatus: Bool) {
        interactor?.changeItemStatus(itemKey: itemKey, newStatus: newStatus)
        
        //Reflect this in MenuVC
        
    }
}
