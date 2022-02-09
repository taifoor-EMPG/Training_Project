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
    func getList(listKey: Int) -> List? {
        let x = source?.getList(listKey: listKey)
        
        if x == nil
        {
            print("PopulateListInteractor >> In getList >> Error: Failed to Fetch")
            return nil
        }
        return x
    }
    
    func changeListTitle(listKey: Int, newTitle: String) -> Bool
    {
        //Check if List with newTitle exists
        var x = source?.listExists(listName: newTitle)
        if x == nil || x == true
        {
            return false
        }
        
        //Rename the List with ListKey
        x = source?.changeListName(listKey: listKey, newListName: newTitle)
        if x == nil
        {
            print("PopulateListInteractor >> In changeListTitle")
            return false
        }
        return x!
    }
    
    func allowEditing(listKey: Int) -> Bool {
        let x = source?.allowEditing(listKey: listKey)
        
        if x == nil
        {
            print("PopulateListInteractor >> In allowEditing >> Error: Failed to Fetch")
            return false
        }
        return x!
    }
    
    func changeItemStatus(itemKey: Int, newStatus: Bool) {
        source?.changeStatusOfItem(itemKey: itemKey, newStauts: newStatus)
    }
    func changeItemText(itemKey: Int, newText: String) {
        source?.changeTextOfItem(itemKey: itemKey, newText: newText)
    }
    
    func newListItem(listKey: Int, text: String) {
        let x = source?.addItemtoList(listKey: listKey, itemText: text)
        
        if x == nil || x == false
        {
            print("PopulateListInteractor >> In newListItem >> Error: Failed to Fetch")
        }
    }
    
    func deleteListItem(listKey: Int, itemKey: Int) -> Bool {
        let x = source?.removeItemFromList(listKey: listKey, itemKey: itemKey)
        
        if x == nil || x == false
        {
            print("PopulateListInteractor >> In newListItem >> Error: Failed to Fetch")
            return false
        }
        return true
    }
}
