//
//  PopulateListRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//


import UIKit

class PopulateListRouter: Proto_PTOR_PopulateList
{
    static func createModule(with listName: String) -> UIViewController?
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PopulateList", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PopulateList") as! PopulateList
        let presenter: Proto_VTOP_PopulateList & Proto_ITOP_PopulateList = PopulateListPresenter()
            
        viewController.presenter = presenter
        viewController.presenter?.router = PopulateListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PopulateListInteractor()
            
        //Set Data Members HerePopulateList
        presenter.viewDidLoad(listName)
        
        return viewController
    }
}
