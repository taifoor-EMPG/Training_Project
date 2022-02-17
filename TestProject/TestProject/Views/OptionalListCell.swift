//
//  OptionalListCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

class OptionalListCell: UITableViewCell {
  
  //MARK: DATA MEMBERS
  private var listKey: Int = Constants.errorFetchCode
  @IBOutlet weak var listTitle: UILabel!
  @IBOutlet weak var count: UILabel!
  //END OF DATA MEMBERS
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
    
  }
  
  func setupCell(listKey: Int, text: String, count: String)
  {
    self.listKey = listKey
    listTitle.text = text
    self.count.text = count
  }
  
  func getListKey() -> Int
  {
    return listKey
  }
}
