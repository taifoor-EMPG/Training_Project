//
//  PopulateListInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateListInteractor: Proto_PTOI_PopulateList
{
   //DATA MEMBERS
    
    var presenter: Proto_ITOP_PopulateList?
    
    //END OF DATA MEMBERS
    
   
    func getList(listName: String) -> List? {
        return ListDataBase.getList(listName: listName)
    }
    
    
}
