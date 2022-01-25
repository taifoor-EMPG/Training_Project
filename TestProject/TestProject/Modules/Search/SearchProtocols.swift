//
//  PopulateMenuProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol Proto_VTOP_Search
{
    //Data Members
    var view: Proto_PTOV_Search? {get set}
    var interactor: Proto_PTOI_Search? {get set}
    var router: Proto_PTOR_Search? {get set}
    
    //Setting Up View
    
    //Navigation to Other Screens

    //Setting View Table
    
    //Misc Functions to Populate View
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol Proto_PTOV_Search: AnyObject
{
    var presenter: (Proto_VTOP_Search & Proto_ITOP_Search)? {get set}
    
    //Function to Open List Should be here and implemented on the backend
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol Proto_PTOI_Search
{
    var presenter: Proto_ITOP_Search? {get set}
}

protocol Proto_ITOP_Search
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol Proto_PTOR_Search
{
    static func createModule() -> UIViewController?
}

