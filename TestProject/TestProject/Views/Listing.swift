//
//  Listing.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 04/02/2022.
//

import UIKit

protocol ListingCellProtocol
{
  func addListToGroup(listKey: Int, groupKey: Int)
  func removeListFromGroup(listKey: Int, groupKey: Int)
}


class Listing: UITableViewCell
{
  //DATA MEMBERS
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var button: UIButton!
  
  private var deletegate: ListingCellProtocol?
  
  private var listKey: Int?
  private var isIncluded: Bool?
  private var openedGroupKey: Int?
  
  //END DATA MEMBERS
  
  
  func setupCell(listKey: Int, listName: String, openedGroupKey:Int, isAdded: Bool, reference: ListingCellProtocol?)
  {
    self.listKey = listKey
    self.isIncluded = isAdded
    self.openedGroupKey = openedGroupKey
    
    do{
    try title.attributedText = NSAttributedString(markdown: listName)
    }
    catch{
      LoggingSystemFlow.printLog("Listing >> setupCell >> Failed to Set Text")
    }
    deletegate = reference
    setImage()
  }
  
  private func setImage()
  {
    DispatchQueue.main.async {
      if self.isIncluded == true
      {
        self.button.setImage(UIImage(systemName: Constants.UIDefaults.groupPrompt.addedImage), for: .normal)
      }
      else
      {
        self.button.setImage(UIImage(systemName: Constants.UIDefaults.groupPrompt.addImage), for: .normal)
      }
    }
  }
  
  @IBAction func addRemovePressed(_ sender: UIButton){
    if isIncluded == true
    {
      isIncluded = false
      setImage()
      deletegate?.removeListFromGroup(listKey: listKey ?? Constants.newListKey, groupKey: openedGroupKey ?? Constants.newGroupKey)
    }
    else
    {
      isIncluded = true
      setImage()
      deletegate?.addListToGroup(listKey: listKey ?? Constants.newListKey, groupKey: openedGroupKey ?? Constants.newGroupKey)
    }
  }
}
