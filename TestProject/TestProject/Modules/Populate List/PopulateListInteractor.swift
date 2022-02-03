//
//  PopulateListInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateListInteractor: ProtocolPresenterToInteractorPopulateList
{
   //DATA MEMBERS
    
    private weak var presenter: ProtocolInteractorToPresenterPopulateList?
    private var source: ProtocolDatasource?
    
    //END OF DATA MEMBERS
    
    init(source : ProtocolDatasource?)
    {
        guard source != nil else
        {
            //RAISE SOME ERROR HERE
            return
        }
        self.source = source
    }

    func setPresenter(presenter: ProtocolInteractorToPresenterPopulateList?)
    {
        guard presenter != nil else
        {
            //RAISE SOME ERROR HERE
            return
        }
        self.presenter = presenter
    }
}

//MARK: Use Case Functionalities
extension PopulateListInteractor
{
    func getList(listName: String) -> List? {
        
        print("PopulateListInteractor >> In getList")
        return nil
        //return ListDataBase.getList(listName: listName)
    }
    
    func changeListTitle(oldTitle: String, newTitle: String) -> Bool
    {
        print("PopulateListInteractor >> In changeListTitle")
        return false
        //return ListDataBase.changeOptionalListName(oldName: oldTitle, newName: newTitle)
    }
    
    func allowEditing(_ listName: String) -> Bool {
        print("PopulateListInteractor >> In allowEditing")
        return false
        //return ListDataBase.isPermanentList(listName)
    }
}
