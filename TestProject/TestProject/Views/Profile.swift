//
//  Profile.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class Profile: UIViewController, ProtocolPresenterToViewProfile
{
    //MARK: DATA MEMBERS

    private var presenter: (ProtocolViewToPresenterProfile & ProtocolInteractorToPresenterProfile)?
    
    //END OF DATA MEMBERS
    
    func setPresenter(_ presenter: (ProtocolViewToPresenterProfile & ProtocolInteractorToPresenterProfile)?)
    {
        self.presenter = presenter
    }
    
}
