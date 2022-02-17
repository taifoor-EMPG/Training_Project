//
//  ProfileRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//


import UIKit

class ProfileRouter: ProtocolPresenterToRouterProfile
{
    static func createModule() -> UIViewController? {
      let storyBoard: UIStoryboard = UIStoryboard(name: Constants.ViewControllerIDs.Profile.storyboardID, bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.Profile.identifier) as! Profile
        
        let source = DataRepository(plugin: CoreData())
        
        let presenter: ProtocolViewToPresenterProfile & ProtocolInteractorToPresenterProfile = ProfilePresenter(view: viewController, interactor: ProfileInteractor(source: source), router: ProfileRouter())
        
        presenter.initInteractor()
        viewController.setPresenter(presenter)
            
        //Set Data Members Here
        
        return viewController
    }
}
