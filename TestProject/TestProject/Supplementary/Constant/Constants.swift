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
    static let errorFetchCode = -1
    static let errorCodes = Utilities.getErrorCodes()
    
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
        }
        
        struct newGroup
        {
            static let title = "New Group"
            static let newGroupTitle = "Untitled Group"
            static let leftButtonText = "Cancel"
            static let rightButtonText = "Create"            
        }
    }
    
    //END OF DATA MEMBERS
}
