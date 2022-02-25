//
//  PopulateListProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol ProtocolViewToPresenterPopulateList
{
    //Setting Up View
    func viewDidLoad(_ listName: String, firstOpen: Bool)
    func initInteractor()
    
    //Setting View Table
    func numberOfRowsInSection() -> Int
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    
    //Navigation to Other Screens
    func pushToEditText(itemNumber: Int)
    
    
    //Misc Functions to Populate View
    func getListName() -> String
    func changeListTitle(oldTitle: String, newTitle: String) -> Bool
    func allowEditing(_ listName:String) -> Bool
    func isFirstOpen() -> Bool
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol ProtocolPresenterToViewPopulateList: AnyObject
{
    //Function to Open List Should be here and implemented on the backend
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol ProtocolPresenterToInteractorPopulateList: AnyObject
{
    func setPresenter(presenter: ProtocolInteractorToPresenterPopulateList?)
    
    func getList(listName: String) -> List?
    func changeListTitle(oldTitle: String, newTitle: String) -> Bool
    func allowEditing(_ listName: String) -> Bool
}

protocol ProtocolInteractorToPresenterPopulateList: AnyObject
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol ProtocolPresenterToRouterPopulateList
{
    static func createModule(with listName: String, editable: Bool) -> UIViewController?
}

