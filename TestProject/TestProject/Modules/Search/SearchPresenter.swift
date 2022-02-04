//
//  SearchPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class SearchPresenter: ProtocolViewToPresenterSearch, ProtocolInteractorToPresenterSearch
{
    //DATA MEMBERS
    
    private var view: ProtocolPresenterToViewSearch?
    private var interactor: ProtocolPresenterToInteractorSearch?
    private var router: ProtocolPresenterToRouterSearch?
    
    //END OF DATA MEMBERS
    
    init(view: ProtocolPresenterToViewSearch?, interactor: ProtocolPresenterToInteractorSearch?, router: ProtocolPresenterToRouterSearch?)
    {
        //Setting Up Data Members
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func initInteractor() {
        interactor?.setPresenter(presenter: self)
    }
}
