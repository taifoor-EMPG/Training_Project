//
//  PopulateMenuInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import Foundation

//MARK: - All Methods that the Presenter can call to get information from API/DB come here

class PopulateMenuInteractor: Proto_PTOI_PopulateMenu
{
    //Data Members
    
    var presenter: Proto_ITOP_PopulateMenu?
    
    //End of Data Members
    
    
    
    func getOptionalListCount() -> Int {
        return ListDataBase.getOptionalListCount()
    }
    
    func getOptionalListTitleArray() -> [String] {
        return ListDataBase.getOptionalListTitles()
    }
    
    func getListSize(listName: String) -> String? {
        return ListDataBase.getListSize(listName: listName)
    }
    
    func createNewList(listName: String) -> Bool {
        return ListDataBase.addOptionalList(title: listName)
    }
    
    func removeOptionalList(listName: String) -> [String] {
        if ListDataBase.removeOptionalList(listName: listName) == true
        {
            return ListDataBase.getOptionalListTitles()
        }
        return []
    }
}
