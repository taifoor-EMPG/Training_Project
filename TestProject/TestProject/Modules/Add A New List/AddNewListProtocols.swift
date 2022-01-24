//
//  AddNewListProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol Proto_VTOP_AddNewList
{
    //Data Members
    var view: Proto_PTOV_AddNewList? {get set}
    var interactor: Proto_PTOI_AddNewList? {get set}
    var router: Proto_PTOR_AddNewList? {get set}
    
    //Setting Up View
    func viewDidLoad()
    
    //Navigation to Other Screens
    func pushToPopulateMenu()
    
    //Misc Functions to Populate View
    
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol Proto_PTOV_AddNewList: AnyObject
{
    var presenter: (Proto_VTOP_AddNewList & Proto_ITOP_AddNewList)? {get set}
    
    //Function to Open List Should be here and implemented on the backend
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol Proto_PTOI_AddNewList
{
    var presenter: Proto_ITOP_AddNewList? {get set}
    
}

protocol Proto_ITOP_AddNewList
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol Proto_PTOR_AddNewList
{
    static func createModule() -> UINavigationController?
    func pushToPopulateMenu()
}

