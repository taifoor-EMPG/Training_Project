//
//  Search.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class Search: UIViewController, ProtocolPresenterToViewSearch
{
    //DATA MEMBERS
    
    private var presenter: (ProtocolViewToPresenterSearch & ProtocolInteractorToPresenterSearch)?
    
    ///View Controller Outlets
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var bar: UIStackView!
    //END OF DATA MEMBERS
    
    
    func setPresenter(_ presenter: (ProtocolViewToPresenterSearch & ProtocolInteractorToPresenterSearch)?)
    {
        self.presenter = presenter
    }
    
    
    
    override func viewDidLoad() {
        //searchBox.becomeFirstResponder()
        self.view.bringSubviewToFront(bar)
        
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
