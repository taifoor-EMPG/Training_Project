//
//  ListItemCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

protocol ListItemCellProtocols
{
  func didTapChecked(itemKey: Int, newStatus: Bool)
}

class ListItemCell: UITableViewCell {
  
  //MARK: DATA MEMBERS
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var checkMark: UIButton!
  @IBOutlet weak var cellView: UIView!
  
  private var status:Bool?
  private var itemKey:Int?
  
  private var delegate: ListItemCellProtocols?
  //END OF DATA MEMBERS
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func getText() -> String
  {
    return label.text ?? Constants.emptyString
  }
  
  func getItemKey() -> Int
  {
    return itemKey ?? Constants.newListItemKey
  }
  
  func setBackgroundColor(_ color: UIColor)
  {
    cellView.backgroundColor = color
  }
  
  @IBAction func tappedCheck(_ sender: UIButton) {
    
    let attrRedStrikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]
    
    let attrBlueNoStrikethroughStyle = [NSAttributedString.Key.foregroundColor:  UIColor.label,]
    
    if status == false
    {
      status = true
      delegate?.didTapChecked(itemKey: itemKey ?? Constants.newListItemKey, newStatus: status ?? false)
      DispatchQueue.main.async { [self] in
        //Update UI on main thread
        checkMark.setImage(UIImage(named: Constants.UIDefaults.Images.checkedCircle), for: .normal)
        //Strike Through Text
        let text = NSAttributedString(string: label.text ?? Constants.emptyString, attributes: attrRedStrikethroughStyle)
        label.attributedText = text
      }
      
    }
    else
    {
      status = false
      delegate?.didTapChecked(itemKey: itemKey ?? Constants.newListItemKey, newStatus: status ?? false)
      DispatchQueue.main.async { [self] in
        //Update UI on main thread
        checkMark.setImage(UIImage(named: Constants.UIDefaults.Images.uncheckedCircle), for: .normal)
        //Unstrike through text
        let text = NSAttributedString(string: label.text ?? Constants.emptyString, attributes: attrBlueNoStrikethroughStyle)
        label.attributedText = text
      }
      
    }
  }
  
  func setupCell(itemKey: Int, text: String, status: Bool, reference: ListItemCellProtocols?)
  {
    self.delegate = reference
    
    self.itemKey = itemKey
    let attrRedStrikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]
    
    label.text = text
    self.status = status
    if status == true
    {
      checkMark.setImage(UIImage(named: Constants.UIDefaults.Images.checkedCircle), for: .normal)
      let temp = NSAttributedString(string: label.text!, attributes: attrRedStrikethroughStyle)
      label.attributedText = temp
    }
    else
    {
      checkMark.setImage(UIImage(named: Constants.UIDefaults.Images.uncheckedCircle), for: .normal)
    }
  }
  
}
