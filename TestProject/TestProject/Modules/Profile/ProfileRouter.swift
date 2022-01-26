//
//  ProfileRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//


import UIKit

class ProfileRouter: Proto_PTOR_Profile
{
    static func createModule() -> UIViewController? {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "Profile") as! Profile
        let presenter: Proto_VTOP_Profile & Proto_ITOP_Profile = ProfilePresenter()
            
        viewController.presenter = presenter
        viewController.presenter?.router = ProfileRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProfileInteractor()
            
        //Set Data Members Here
        
        return viewController
    }
}
