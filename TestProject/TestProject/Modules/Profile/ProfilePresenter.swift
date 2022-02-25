//
//  ProfilePresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 26/01/2022.
//

import UIKit

class ProfilePresenter: ProtocolViewToPresenterProfile, ProtocolInteractorToPresenterProfile
{
    //DATA MEMBERS
    
    private var view: ProtocolPresenterToViewProfile?
    private var interactor: ProtocolPresenterToInteractorProfile?
    private var router: ProtocolPresenterToRouterProfile?
    
    //END OF DATA MEMBERS
    
    init(view: ProtocolPresenterToViewProfile?, interactor: ProtocolPresenterToInteractorProfile?, router: ProtocolPresenterToRouterProfile?)
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
