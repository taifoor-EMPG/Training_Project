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
    
    //func pushToMovieDetail(on view: Proto_PTOV_PopulateMenu?, with: List) {
        
        //if let movieDetailViewController = AddNewListRouter.createModule(with: with)
        
            //let viewController = view as! MovieListViewController
            //viewController.navigationController?.pushViewController(movieDetailViewController, animated: true)
      
    //}
    
    func pushToProfile() {
        return
    }
    
    func pushToSearch(view: Proto_PTOV_PopulateMenu?) {
        
        if let searchVC = SearchRouter.createModule()
        {
            let viewController = view as! MenuVC
            viewController.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    //Wrapper Function
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
    
    
    func pushToAddNewList() {
        return
    }
}
