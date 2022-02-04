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

    func setPresenter(presenter: ProtocolInteractorToPresenterProfile?)
    {
        guard presenter != nil else
        {
            //RAISE SOME ERROR HERE
            return
        }
        self.presenter = presenter
    }
}
