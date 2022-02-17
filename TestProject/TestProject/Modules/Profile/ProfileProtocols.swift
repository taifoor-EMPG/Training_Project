//
//  ProfileProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol ProtocolViewToPresenterProfile
{
    //Setting Up View
    func initInteractor()
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol ProtocolPresenterToViewProfile: AnyObject
{
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol ProtocolPresenterToInteractorProfile
{
    func setPresenter(presenter: ProtocolInteractorToPresenterProfile?)
}

protocol ProtocolInteractorToPresenterProfile: AnyObject
{
    
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol ProtocolPresenterToRouterProfile
{
    static func createModule() -> UIViewController?
}


