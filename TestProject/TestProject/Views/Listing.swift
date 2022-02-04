//
//  Listing.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 04/02/2022.
//

import UIKit

class Listing: UITableViewCell
{
    //DATA MEMBERS
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var listKey: Int?
    private var isIncluded: Bool?
    
    //END DATA MEMBERS
    
    
    func setupCell(listKey: Int, listName: String, isAdded: Bool)
    {
        self.listKey = listKey
        self.isIncluded = isAdded
        //Come Back to this later
        try! title.attributedText = NSAttributedString(markdown: listName)
        setImage()
    }
    
    private func setImage()
    {
        if isIncluded == true
        {
            button.setImage(UIImage(systemName: Constants.UIDefaults.groupPrompt.addedImage), for: .normal)
        }
        else
        {
            button.setImage(UIImage(systemName: Constants.UIDefaults.groupPrompt.addImage), for: .normal)
        }
    }
    
    @IBAction func addRemovePressed(_ sender: UIButton) {
        if isIncluded == true
        {
            
        }
        else
        {
            
        }
    }
}
