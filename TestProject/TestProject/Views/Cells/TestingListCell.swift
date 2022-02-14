//
//  TestingListCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 14/02/2022.
//

import UIKit

class TestingListCell: UITableViewCell
{
  //MARK: DATA MEMBERS
  @IBOutlet weak var key: UILabel!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var isPermanet: UILabel!
  @IBOutlet weak var groupName: UILabel!
  //END DATA MEMBERS
  
  func setupCell(key: Int, name: String, isPermanent: Bool, groupName: String)
  {
    self.key.text = String(key)
    self.name.text = name
    if isPermanent == true
    {
      self.isPermanet.text = "Permanent"
    }
    else
    {
      self.isPermanet.text = "Optional"
    }
    self.groupName.text = groupName
    
  }
  
}
