//
//  PopulateMenuPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import UIKit

class PopulateMenuPresenter: Proto_VTOP_PopulateMenu, Proto_ITOP_PopulateMenu
{

    //Data Members
    var view: Proto_PTOV_PopulateMenu?
    var interactor: Proto_PTOI_PopulateMenu?
    var router: Proto_PTOR_PopulateMenu?
    
    var optionalListTitle = [String]()
    
    //End of Data Members
    
    
    func viewDidLoad() {
        //view?.showActivity()
        
        //Presenter is asking to Interact to load new data
        optionalListTitle = interactor?.getOptionalListTitleArray() ?? []
    }
    
    //MARK: - The next 4 functions perform screen switching
    func pushToSearch() {
        print("Search Should be performed")
    }
    
    func pushToProfile() {
        print("Show Proxy Here")
    }
    
    func pushToAddNewList() {
        print("Will work on creating a new list")
    }
    
    func pushToOpenList(listName: String) {
        router?.pushToOpenList(view: view, with: listName)
    }
    
    
    func numberOfRowsInSection() -> Int {
        return interactor?.getOptionalListCount() ?? 0
    }
    
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.labels.optionalListCell, for: indexPath) as? OptionalListCell {
            cell.setupCell(text: optionalListTitle[indexPath.row], count: interactor?.getListSize(listName: optionalListTitle[indexPath.row]) ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    func getListSize(listName: String) -> String? {
        interactor?.getListSize(listName: listName)
    }
}



//Extending to Implement Proto_VTOP_PopulateMenu
extension PopulateMenuPresenter
{
    
}

//Extending to Implement Proto_ITOP_PopulateMenu
extension PopulateMenuPresenter
{
    
}
