//
//  PopulateListPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateListPresenter: Proto_VTOP_PopulateList, Proto_ITOP_PopulateList
{
    //DATA MEMBERS
    
    var view: Proto_PTOV_PopulateList?
    var interactor: Proto_PTOI_PopulateList?
    var router: Proto_PTOR_PopulateList?
    
    private var listName: String = ""
    private var openedList: List?
    private var listItems:[String] = []
    private var listItemsStatus:[Bool] = []
    
    private var firstOpen: Bool = false
    
    //END OF DATA MEMBERS
    
    
    //Setting up screen
    func viewDidLoad(_ listName: String, firstOpen: Bool) {
        //Presenter is asking to Interact to load new data
        self.listName = listName
        openedList = interactor?.getList(listName: listName)
        listItems = openedList?.getListItemsText() ?? []
        listItemsStatus = openedList?.getListItemStauts() ?? []
        self.firstOpen = firstOpen
    }
    
    //Setting up Table
    func numberOfRowsInSection() -> Int {
        return openedList!.getListSize()
    }
    
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.labels.listItemCell, for: indexPath) as? ListItemCell {
            cell.setupCell(text: self.listItems[indexPath.row], status: self.listItemsStatus[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func pushToEditText(itemNumber: Int) {
        print("This is tapped")
    }
    
    func getListName() -> String
    {
        return listName
    }
    
    func changeListTitle(oldTitle: String, newTitle: String) -> Bool
    {
        let result = interactor?.changeListTitle(oldTitle: oldTitle, newTitle: newTitle)
        
        if result == nil
        {
            return false
        }
        
        return result!
    }
    
    func allowEditing(_ listName: String) -> Bool {
        let result = interactor?.allowEditing(listName)
        
        if result == nil
        {
            return false
        }
        return result!
    }
    
    func isFirstOpen() -> Bool {
        return firstOpen
    }
    
    
}
