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
    
    static let navBarReturnTitle = "Lists"
    static let listsTitleArray = ["My Day", "Important", "Planned", "Assigned to Me", "Tasks"]
    private static var optionalListsTitleArray:[String] = ["Travel Items"]
    
    struct UIDefaults
    {
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
    }
    
    //END OF DATA MEMBERS
    
    
    //Adds Title of an Optional List
    static func addOptionalList(_ name:String) -> Bool
    {
        if !optionalListsTitleArray.contains(name)
        {
            Constants.optionalListsTitleArray.append(name)
            return true
        }
        return false
    }
    
    //Returns the Entire array of Optional List Titles
    static func getOptionalListTitles() -> [String]
    {
        return optionalListsTitleArray
    }
    
    //Returns if a List Name exists in the Optional List Array
    static func doesExist(listName: String) -> Bool
    {
        return optionalListsTitleArray.contains(listName)
    }
    
    //Removes a Title From Optional List Array
    static func removeList(listName: String) -> Int?
    {
        if doesExist(listName: listName)
        {
            let index = optionalListsTitleArray.firstIndex(of: listName)!
            optionalListsTitleArray.remove(at: index)
            return index
            
        }
        return nil
    }
}
