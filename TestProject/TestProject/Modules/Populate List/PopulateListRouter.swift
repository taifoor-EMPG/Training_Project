//
//  PopulateListRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//


import UIKit

class PopulateListRouter: ProtocolPresenterToRouterPopulateList
{
    static func createModule(with listName: String, listKey: Int, editable: Bool) -> UIViewController?
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PopulateList", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PopulateList") as! PopulateList
        
        let source = Datasource(plugin: CoreData())
        
        let presenter: ProtocolViewToPresenterPopulateList & ProtocolInteractorToPresenterPopulateList = PopulateListPresenter(view: viewController, interactor: PopulateListInteractor(source: source), router: PopulateListRouter())
        
        presenter.initInteractor()
        viewController.setPresenter(presenter)
        
        //Set Data Members HerePopulateList
        presenter.viewDidLoad(listName, listKey: listKey, firstOpen: editable)
        
        return viewController
    }
}
