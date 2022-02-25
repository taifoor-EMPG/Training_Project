//
//  ProfileInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 26/01/2022.
//

import UIKit

class ProfileInteractor: ProtocolPresenterToInteractorProfile
{
  
    //DATA MEMBERS
    
    private weak var presenter: ProtocolInteractorToPresenterProfile?
    private var source: ProtocolDataRepository?
    
    //END OF DATA MEMBERS
    
    init(source : ProtocolDataRepository)
    {
        self.source = source
    }

    func setPresenter(presenter: ProtocolInteractorToPresenterProfile)
    {
        self.presenter = presenter
    }
}
