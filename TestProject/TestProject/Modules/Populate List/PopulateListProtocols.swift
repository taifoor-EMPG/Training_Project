//
//  PopulateListProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol Proto_VTOP_PopulateList
{
    //Data Members
    var view: Proto_PTOV_PopulateList? {get set}
    var interactor: Proto_PTOI_PopulateList? {get set}
    var router: Proto_PTOR_PopulateList? {get set}
    
    //Setting Up View
    func viewDidLoad(_ listName: String)
    
    //Setting View Table
    func numberOfRowsInSection() -> Int
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    
    //Navigation to Other Screens
    func pushToEditText(itemNumber: Int)
    
    
    //Misc Functions to Populate View
    func getListName() -> String
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol Proto_PTOV_PopulateList: AnyObject
{
    var presenter: (Proto_VTOP_PopulateList & Proto_ITOP_PopulateList)? {get set}
    
    //Function to Open List Should be here and implemented on the backend
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol Proto_PTOI_PopulateList
{
    var presenter: Proto_ITOP_PopulateList? {get set}
    
    func getList(listName: String) -> List?
}

protocol Proto_ITOP_PopulateList
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol Proto_PTOR_PopulateList
{
    static func createModule(with listName: String, editable: Bool) -> UIViewController?
}

