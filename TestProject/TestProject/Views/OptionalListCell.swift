//
//  OptionalListCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

class OptionalListCell: UITableViewCell {

    //DATA MEMBERS
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var count: UILabel!
    //END OF DATA MEMBERS
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func setupCell(text: String, count: String)
    {
        listTitle.text = text
        self.count.text = count
    }
}
