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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        
        let NavigationController = UINavigationController(rootViewController: viewController)
        
        let source = Datasource(plugin: CoreData())
        
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "GroupOptions", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "GroupOptions") as! GroupOptions
        return viewController
    }
    
    func createGroupPrompt() -> GroupPrompt
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "GroupPrompt", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "GroupPrompt") as! GroupPrompt
        return viewController
    }
    
    //Wrapper Function
    //Changes to OpenList - Also acts as NewList Creater
    func pushToOpenList(view: ProtocolPresenterToViewPopulateMenu?, with listName: String)
    {
        pushToOpenList(view: view, with: listName, editable: false)
    }
    
    //Actual Implementation
    func pushToOpenList(view: ProtocolPresenterToViewPopulateMenu?, with listName: String, editable: Bool) {
        
        if let openListVC = PopulateListRouter.createModule(with: listName, editable: editable)
        {
            let viewController = view as! MenuVC
            viewController.navigationController?.pushViewController(openListVC, animated: true)
        }
    }
}
