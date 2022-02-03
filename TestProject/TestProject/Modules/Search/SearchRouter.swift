//
//  SearchRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.

import UIKit

class SearchRouter: ProtocolPresenterToRouterSearch
{
    static func createModule() -> UIViewController? {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "Search") as! Search
        
        let source = Datasource(plugin: CoreData())
        
        let presenter: ProtocolViewToPresenterSearch & ProtocolInteractorToPresenterSearch = SearchPresenter(view: viewController, interactor: SearchInteractor(source: source), router: SearchRouter())
        
        presenter.initInteractor()
        viewController.setPresenter(presenter)
            
        //Set Data Members Here
        
        return viewController
    }
}
