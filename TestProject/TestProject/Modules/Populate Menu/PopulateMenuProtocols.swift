//
//  PopulateMenuProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol Proto_VTOP_PopulateMenu
{
    //Data Members
    var view: Proto_PTOV_PopulateMenu? {get set}
    var interactor: Proto_PTOI_PopulateMenu? {get set}
    var router: Proto_PTOR_PopulateMenu? {get set}
    
    //Setting Up View
    func viewDidLoad()
    
    //Navigation to Other Screens
    func pushToSearch()
    func pushToProfile()
    func pushToAddNewList()
    func pushToOpenList(listName: String)
    
    
    //Setting View Table
    func numberOfRowsInSection() -> Int
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    
    //Misc Functions to Populate View
    func getListSize(listName: String) -> String?
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol Proto_PTOV_PopulateMenu: AnyObject
{
    var presenter: (Proto_VTOP_PopulateMenu & Proto_ITOP_PopulateMenu)? {get set}
    
    //Function to Open List Should be here and implemented on the backend
    func showActivity()
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol Proto_PTOI_PopulateMenu
{
    var presenter: Proto_ITOP_PopulateMenu? {get set}
    
    
    func getOptionalListCount() -> Int
    func getOptionalListTitleArray() -> [String]
    func getListSize(listName: String) -> String?
    func createNewList(listName: String) -> Bool
}

protocol Proto_ITOP_PopulateMenu
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol Proto_PTOR_PopulateMenu
{
    static func createModule() -> UINavigationController?
    func pushToProfile()
    func pushToSearch()
    func pushToOpenList(view: Proto_PTOV_PopulateMenu?, with listName: String)
    func pushToOpenList(view: Proto_PTOV_PopulateMenu?, with listName: String, editable: Bool)
    func pushToAddNewList()
}

