//
//  PopulateMenuRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

class PopulateMenuRouter: Proto_PTOR_PopulateMenu
{
    static func createModule() -> UINavigationController? {
        
        //This all should come from a Factory >> Dependency Injection
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        
        let NavigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: Proto_VTOP_PopulateMenu & Proto_ITOP_PopulateMenu = PopulateMenuPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PopulateMenuRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PopulateMenuInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return NavigationController
    }
    
    //Changes to Profile Screen
    func pushToProfile(view: Proto_PTOV_PopulateMenu?) {
        if let profileVC = ProfileRouter.createModule()
        {
            let viewController = view as! MenuVC
            viewController.present(profileVC, animated: true, completion: nil)
            //viewController.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    //Changes to Search Screen
    func pushToSearch(view: Proto_PTOV_PopulateMenu?) {
        
        if let searchVC = SearchRouter.createModule()
        {
            let viewController = view as! MenuVC
            searchVC.modalPresentationStyle = .fullScreen
            viewController.present(searchVC, animated: true, completion: nil)
            
            //viewController.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    //Wrapper Function
    //Changes to OpenList - Also acts as NewList Creater
    func pushToOpenList(view: Proto_PTOV_PopulateMenu?, with listName: String)
    {
        pushToOpenList(view: view, with: listName, editable: false)
    }
    
    func pushToOpenList(view: Proto_PTOV_PopulateMenu?, with listName: String, editable: Bool) {
        
        if let openListVC = PopulateListRouter.createModule(with: listName, editable: editable)
        {
            let viewController = view as! MenuVC
            viewController.navigationController?.pushViewController(openListVC, animated: true)
        }
    }
}
