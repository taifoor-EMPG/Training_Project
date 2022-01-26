//
//  Search.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class Search: UIViewController, Proto_PTOV_Search
{
    //DATA MEMBERS
    
    @IBOutlet weak var searchBox: UITextField!
    var presenter: (Proto_ITOP_Search & Proto_VTOP_Search)?
    
    //END OF DATA MEMBERS
    
    
    override func viewDidLoad() {
        //searchBox.becomeFirstResponder()
    }
    
    
}
