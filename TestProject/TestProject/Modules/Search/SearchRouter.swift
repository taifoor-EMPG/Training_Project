//
//  SearchRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.

import UIKit

class SearchRouter: Proto_PTOR_Search
{
    static func createModule() -> UIViewController? {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "Search") as! Search
        let presenter: Proto_VTOP_Search & Proto_ITOP_Search = SearchPresenter()
            
        viewController.presenter = presenter
        viewController.presenter?.router = SearchRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SearchInteractor()
            
        //Set Data Members Here
        
        return viewController
    }
}
