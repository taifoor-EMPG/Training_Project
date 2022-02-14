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
      let storyBoard: UIStoryboard = UIStoryboard(name: Constants.ViewControllerIDs.PopulateList.storyboardID, bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.PopulateList.identifier) as! PopulateList
        
        let source = DataRepository(plugin: CoreData())
        
        let presenter: ProtocolViewToPresenterPopulateList & ProtocolInteractorToPresenterPopulateList = PopulateListPresenter(view: viewController, interactor: PopulateListInteractor(source: source), router: PopulateListRouter())
        
        presenter.initInteractor()
        viewController.setPresenter(presenter)
        
        //Set Data Members HerePopulateList
        presenter.viewDidLoad(listName, listKey: listKey, firstOpen: editable)
        
        return viewController
    }
}
