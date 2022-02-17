//
//  PopulateMenuRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

class PopulateMenuRouter: ProtocolPresenterToRouterPopulateMenu
{
    static func createModule() -> UINavigationController? {
        
      let storyBoard: UIStoryboard = UIStoryboard(name: Constants.ViewControllerIDs.Menu.storyboardID, bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.Menu.identifier) as! MenuVC
        
        let NavigationController = UINavigationController(rootViewController: viewController)
        
        let source = DataRepository(plugin: CoreData())
        
        let presenter: ProtocolViewToPresenterPopulateMenu & ProtocolInteractorToPresenterPopulateMenu = PopulateMenuPresenter(view: viewController, interactor: PopulateMenuInteractor(source: source), router: PopulateMenuRouter())
        
        presenter.initInteractor()
        viewController.setPresenter(presenter)
        
        return NavigationController
    }
    
    //Changes to Profile Screen
    func pushToProfile(view: ProtocolPresenterToViewPopulateMenu?) {
        if let profileVC = ProfileRouter.createModule()
        {
            let viewController = view as! MenuVC
            viewController.present(profileVC, animated: true, completion: nil)
        }
    }
    
    //Changes to Search Screen
    func pushToSearch(view: ProtocolPresenterToViewPopulateMenu?) {
        if let searchVC = SearchRouter.createModule()
        {
            let viewController = view as! MenuVC
            searchVC.modalPresentationStyle = .fullScreen
            viewController.present(searchVC, animated: true, completion: nil)
        }
    }
    
    func createGroupOptions() -> GroupOptions {
      let storyBoard: UIStoryboard = UIStoryboard(name: Constants.ViewControllerIDs.GroupOptions.storyboardID, bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.GroupOptions.identifier) as! GroupOptions
        return viewController
    }
    
    func createGroupPrompt() -> GroupPrompt
    {
      let storyBoard: UIStoryboard = UIStoryboard(name: Constants.ViewControllerIDs.GroupPrompt.storyboardID, bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIDs.GroupPrompt.identifier) as! GroupPrompt
        return viewController
    }
    
    //Wrapper Function
    //Changes to OpenList - Also acts as NewList Creater
    func pushToOpenList(view: ProtocolPresenterToViewPopulateMenu?, with listName: String, listKey: Int, delegate: ListToMenuUpdate?){
        pushToOpenList(view: view, with: listName, listKey: listKey, editable: false, delegate: delegate)
    }
    
    //Actual Implementation
    func pushToOpenList(view: ProtocolPresenterToViewPopulateMenu?, with listName: String, listKey: Int, editable: Bool, delegate: ListToMenuUpdate?) {
        
        if let openListVC = PopulateListRouter.createModule(with: listName, listKey: listKey, editable: editable, delegate: delegate)
        {
            let viewController = view as! MenuVC
            viewController.navigationController?.pushViewController(openListVC, animated: true)
        }
    }
}
