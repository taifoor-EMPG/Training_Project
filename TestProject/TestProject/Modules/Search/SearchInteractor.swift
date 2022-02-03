//
//  SearchInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class SearchInteractor: ProtocolPresenterToInteractorSearch
{
    //DATA MEMBERS
    
    private weak var presenter: ProtocolInteractorToPresenterSearch?
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

    func setPresenter(presenter: ProtocolInteractorToPresenterSearch?)
    {
        guard presenter != nil else
        {
            //RAISE SOME ERROR HERE
            return
        }
        self.presenter = presenter
    }
}
