//
//  ProfileProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol Proto_VTOP_Profile
{
    //Data Members
    var view: Proto_PTOV_Profile? {get set}
    var interactor: Proto_PTOI_Profile? {get set}
    var router: Proto_PTOR_Profile? {get set}
    
    //Setting Up View
    
    //Navigation to Other Screens

    //Setting View Table
    
    //Misc Functions to Populate View
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol Proto_PTOV_Profile: AnyObject
{
    var presenter: (Proto_VTOP_Profile & Proto_ITOP_Profile)? {get set}
    
    //Function to Open List Should be here and implemented on the backend
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol Proto_PTOI_Profile
{
    var presenter: Proto_ITOP_Profile? {get set}
}

protocol Proto_ITOP_Profile
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol Proto_PTOR_Profile
{
    static func createModule() -> UIViewController?
}


