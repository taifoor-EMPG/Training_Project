//
//  SearchRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.

import UIKit

class SearchRouter: ProtocolPresenterToRouterSearch
{
    static func createModule() -> UIViewController? {
      let storyBoard: UIStoryboard = UIStoryboard(name: Constants.ViewControllerIDs.Search.storyboardID, bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.Search.identifier) as! Search
        
        let source = DataRepository(plugin: CoreData())
        
        let presenter: ProtocolViewToPresenterSearch & ProtocolInteractorToPresenterSearch = SearchPresenter(view: viewController, interactor: SearchInteractor(source: source), router: SearchRouter())
        
        presenter.initInteractor()
        viewController.setPresenter(presenter)
            
        //Set Data Members Here
        
        return viewController
    }
  
  func pushToOpenList(view: ProtocolPresenterToViewSearch?, with listName: String, listKey: Int, editable: Bool) {
      
      if let openListVC = PopulateListRouter.createModule(with: listName, listKey: listKey, editable: editable)
      {
          let viewController = view as! Search
          viewController.navigationController?.pushViewController(openListVC, animated: true)
      }
  }
}
