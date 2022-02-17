//
//  ResultCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 14/02/2022.
//

import UIKit

class ResultCell: UITableViewCell
{
  //MARK: DATA MEMBERS
  @IBOutlet weak var gotoResult: UILabel!
  private var listKey = -1
  //END DATA MEMBERS
  
  func setupCell(listKey: Int, text: String)
  {
    self.listKey = listKey
    gotoResult.text = text
  }
  
  func getKey() -> Int
  {
    return listKey
  }
}
