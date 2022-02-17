//
//  Constants.swift
//  To-Do
//
//  Created by Muhammad Taifoor Saleem on 11/01/2022.
//

import UIKit

struct Constants
{
  static let newListTitle = "Untitled List"
  static let newGroupTitle = "Untitled Group"
  static let newListItemTitle = "Some Task"
  static let newListKey = -2
  static let newGroupKey = -3
  static let newListItemKey = -4
  static let emptyString = ""
  static let errorFetchCode = -1
  static let errorCodes = Utilities.getErrorCodes()
  static let staticListCount = 5
  
  static let projectName = "ToDoApp"
  
  struct UIDefaults
  {
    static let navBarReturnTitle = "Lists"
    
    struct Images
    {
      static let checkedCircle = "circle_checked.png"
      static let uncheckedCircle = "circle_unchecked.png"
    }
    
    struct Labels
    {
      static let optionalListCell = "optionalListCell"
      static let listItemCell = "ListItemCell"
      static let listing = "listing"
      static let searchResultCell = "resultCell"
      static let sectionHeader = "NIBSectionHeader"
    }
    
    struct NewGroup
    {
      static let title = "New Group"
      static let newGroupTitle = "Untitled Group"
      static let leftButtonText = "Cancel"
      static let rightButtonText = "Create"
    }
    struct GroupOptions
    {
      static let deleteTitle = "Delete Group"
      static let deleteImage = "trash"
      static let ungroupTitle = "Ungroup Lists"
      static let ungroupImage = "rectangle.on.rectangle.slash"
      static let renameTitle = "Rename"
    }
    struct GroupPrompt
    {
      static let addedImage = "checkmark"
      static let addImage = "plus"
    }
    struct SectionHeader
    {
      static let optionsImage = "ellipsis"
      static let collapsedImage = "chevron.right"
      static let uncollapsedImage = "chevron.down"
    }
    struct EditListItem
    {
      static let titleMessage = "Alter Text"
      static let leftButtonText = "Cancel"
      static let rightButtonText = "Modify"
    }
    struct NewListItem
    {
      static let titleMessage = "Create New Task"
      static let leftButtonText = "Cancel"
      static let rightButtonText = "Done"
      static let newText = "Take a note of something"
      static let placeholderText = "Add a new task"
    }
    
    struct WallpaperCell
    {
      static let name = "WallpaperCollectionCell"
      static let identifier = "WallpaperCollectionCell"
    }
    
    struct SearchDefault
    {
      static let didNotFindAnything = "questionmark.app.dashed.ar"
      static let defaultImage = "search_title"
      static let delimiter = ">"
    }
    
  }
  
  struct ViewControllerIDs
  {
    struct Menu
    {
      static let storyboardID = "Menu"
      static let identifier = "MenuVC"
    }
    struct GroupOptions
    {
      static let storyboardID = "GroupOptions"
      static let identifier = "GroupOptions"
    }
    struct GroupPrompt
    {
      static let storyboardID = "GroupPrompt"
      static let identifier = "GroupPrompt"
    }
    struct PopulateList
    {
      static let storyboardID = "PopulateList"
      static let identifier = "PopulateList"
    }
    struct Profile
    {
      static let storyboardID = "Profile"
      static let identifier = "Profile"
    }
    struct Search
    {
      static let storyboardID = "Search"
      static let identifier = "Search"
    }
    struct Test
    {
      static let storyboardID = "Tester"
      static let identifier = "Tester"
    }
  }
  
  struct Wallpapers
  {
    static let wallpaperList = ["Col_Blue", "Col_Brown", "Col_Cyan", "Col_Default", "Col_Green", "Col_Grey", "Col_Indigo", "Col_Mint", "Col_Orange", "Col_Pink", "Col_Purple", "Col_Red", "Col_Teal", "Col_Yellow"]
  }
}

