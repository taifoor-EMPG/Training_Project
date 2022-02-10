//
//  Constants.swift
//  To-Do
//
//  Created by Muhammad Taifoor Saleem on 11/01/2022.
//

import UIKit

struct Constants
{
  //DATA MEMBERS
  
  static let newListTitle = "Untitled List"
  static let newListKey = -2
  static let newGroupKey = -3
  static let emptyString = ""
  static let errorFetchCode = -1
  static let errorCodes = Utilities.getErrorCodes()
  
  static let projectName = "ToDoApp"
  
  struct UIDefaults
  {
    static let navBarReturnTitle = "Lists"
    
    struct images
    {
      static let checkedCircle = "circle_checked.png"
      static let uncheckedCircle = "circle_unchecked.png"
    }
    
    struct labels
    {
      static let optionalListCell = "optionalListCell"
      static let listItemCell = "ListItemCell"
      static let listing = "listing"
    }
    
    struct newGroup
    {
      static let title = "New Group"
      static let newGroupTitle = "Untitled Group"
      static let leftButtonText = "Cancel"
      static let rightButtonText = "Create"
    }
    struct groupOptions
    {
      static let deleteTitle = "Delete Group"
      static let deleteImage = "trash"
      static let ungroupTitle = "Ungroup Lists"
      static let ungroupImage = "rectangle.on.rectangle.slash"
      static let renameTitle = "Rename"
    }
    struct groupPrompt
    {
      static let addedImage = "checkmark"
      static let addImage = "plus"
    }
  }
  
  //END OF DATA MEMBERS
}