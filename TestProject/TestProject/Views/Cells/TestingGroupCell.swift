//
//  TestingGroupCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 15/02/2022.
//

import UIKit

class TestingGroupCell: UITableViewCell
{
  //MARK: DATA MEMBERS
  @IBOutlet weak var key: UILabel!
  @IBOutlet weak var name: UILabel!
  //END DATA MEMBERS
  
  
  func setupCell(key : Int, name: String)
  {
    self.key.text = String(key)
    self.name.text = name
  }
}
