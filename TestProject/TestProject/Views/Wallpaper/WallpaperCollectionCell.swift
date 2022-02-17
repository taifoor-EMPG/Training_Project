//
//  WallpaperCollectionCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 15/02/2022.
//

import UIKit

class WallpaperCollectionCell: UICollectionViewCell {

  //MARK: DATA MEMBERS
  @IBOutlet weak var cellView: UIView!
  private var colorName: String?
  //End Data Members
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    cellView.backgroundColor = .systemBackground
    
    cellView.layer.cornerRadius = cellView.frame.size.width/2
    cellView.clipsToBounds = true
    
    cellView.layer.borderColor = UIColor.label.cgColor
    cellView.layer.borderWidth = 2.0
    }
  
  func setupCell(color: UIColor, colorName: String){
    cellView.backgroundColor = color
    self.colorName = colorName
  }

  func getColor() -> UIColor{
    return cellView.backgroundColor ?? .systemBackground
  }
  
  func getColorName() -> String{
    return colorName ?? "default"
  }
  
  static func nib() -> UINib{
    return UINib(nibName: Constants.UIDefaults.WallpaperCell.name, bundle: nil)
  }
}
