//
//  TestingListItemCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 14/02/2022.
//

import UIKit

class TestingListItemCell: UITableViewCell
{
  //MARK: DATA MEMBERS
  @IBOutlet weak var key: UILabel!
  @IBOutlet weak var phrase: UILabel!
  @IBOutlet weak var status: UILabel!
  @IBOutlet weak var listName: UILabel!
  //END DATA MEMBERS
  
  
  func setupCell(key : Int, text: String, status: Bool, listName: String)
  {
    self.key.text = String(key)
    
    self.phrase.text = text
    
    if status{
      self.status.text = "Done"
    }
    else {
      self.status.text = "Pending"
    }
    self.listName.text = listName
  }
}
