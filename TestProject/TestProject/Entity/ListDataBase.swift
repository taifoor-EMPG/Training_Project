//
//  ListDateBase.swift
//  To-Do
//
//  Created by Muhammad Taifoor Saleem on 11/01/2022.
//

import Foundation

struct ListDataBase
{
    //DATA MEMBERS
    
    static var myDay =
    List(list: [ListItem(text: "Complete Task on Project", done: false),
                ListItem(text: "Study for Exam", done: false)])
    
    static var important =
    List(list: [ListItem(text: "Apply for Loan", done: false),
                ListItem(text: "Fill out some Form", done: false)])
    
    static var planned =
    List(list: [ListItem(text: "Implement Project Phase-2", done: false),
                ListItem(text: "Study for Exam", done: true)])
    
    static var assignedToMe =
    List(list: [ListItem(text: "Course 13", done: true)])
    
    static var tasks =
    List(list: [])
    
    static var optionalLists:[List] = [
                                        List(list: [ListItem(text: "Pack Bag", done: false)])       //Travel Items
                                        
                                      ]
    
    private static var optionalListCount = 1
    
    //END OF DATA MEMBERS
    
    
    
    
    //Get List Size - Int
    static func getListSize(listName:String) -> Int
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            return myDay.getListSize()
        case Constants.listsTitleArray[1]:
            return important.getListSize()
        case Constants.listsTitleArray[2]:
            return planned.getListSize()
        case Constants.listsTitleArray[3]:
            return assignedToMe.getListSize()
        case Constants.listsTitleArray[4]:
            return tasks.getListSize()
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    return optionalLists[i].getListSize()
                }
            }
            return -1
        }
    }
    
    //Get List Size - String
    static func getListSize(listName:String) -> String
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            return myDay.getListSize()
        case Constants.listsTitleArray[1]:
            return important.getListSize()
        case Constants.listsTitleArray[2]:
            return planned.getListSize()
        case Constants.listsTitleArray[3]:
            return assignedToMe.getListSize()
        case Constants.listsTitleArray[4]:
            return tasks.getListSize()
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    return optionalLists[i].getListSize()
                }
            }
            return ""
        }
    }
    
    //Add New Optional List
    static func addOptionalList(title: String) -> Bool
    {
        if Constants.addOptionalList(title) == true
        {
            optionalLists.append(List())
            optionalListCount += 1
            return true
        }
        return false
    }
    
    
    //Get Optional Lists Count
    static func getOptionalListCount() -> Int
    {
        return optionalListCount
    }
    
    //Get Optional List Titles
    static func getOptionalListTitles() -> [String]
    {
        return Constants.getOptionalListTitles()
    }
    
    //Get a Particular List (Pass: List Name)
    static func getList(listName: String) -> List?
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            return myDay
        case Constants.listsTitleArray[1]:
            return important
        case Constants.listsTitleArray[2]:
            return planned
        case Constants.listsTitleArray[3]:
            return assignedToMe
        case Constants.listsTitleArray[4]:
            return tasks
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    return optionalLists[i]
                }
            }
            return nil
        }
    }
    
    
    //Add an item to a List (Pass: List Name, List Item Namne)
    static func addItemtoList(listName: String, text: String)
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            return myDay.addItemToList(text: text)
        case Constants.listsTitleArray[1]:
            return important.addItemToList(text: text)
        case Constants.listsTitleArray[2]:
            return planned.addItemToList(text: text)
        case Constants.listsTitleArray[3]:
            return assignedToMe.addItemToList(text: text)
        case Constants.listsTitleArray[4]:
            return tasks.addItemToList(text: text)
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    return optionalLists[i].addItemToList(text: text)
                }
            }
            return
        }
    }
    
    
    //Remove an item from a List (Pass: List Name, List Item Namne)
    static func removeItemFromList(listName: String, text: String) -> Bool
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            return myDay.removeItemFromList(text: text)
        case Constants.listsTitleArray[1]:
            return important.removeItemFromList(text: text)
        case Constants.listsTitleArray[2]:
            return planned.removeItemFromList(text: text)
        case Constants.listsTitleArray[3]:
            return assignedToMe.removeItemFromList(text: text)
        case Constants.listsTitleArray[4]:
            return tasks.removeItemFromList(text: text)
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    return optionalLists[i].removeItemFromList(text: text)
                }
            }
            return false
        }
    }
    
    //Alter Text of an Item in a List (Pass: List Name, Old Text, New Text)
    static func removeItemFromList(listName: String, oldText: String, newText: String) -> Bool
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            return myDay.alterItem(oldText: oldText, newText: newText)
        case Constants.listsTitleArray[1]:
            return important.alterItem(oldText: oldText, newText: newText)
        case Constants.listsTitleArray[2]:
            return planned.alterItem(oldText: oldText, newText: newText)
        case Constants.listsTitleArray[3]:
            return assignedToMe.alterItem(oldText: oldText, newText: newText)
        case Constants.listsTitleArray[4]:
            return tasks.alterItem(oldText: oldText, newText: newText)
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    return optionalLists[i].alterItem(oldText: oldText, newText: newText)
                }
            }
            return false
        }
    }
    
    
    //Mark as Done/(Not Done) - Toggles the Status of List Item
    //Pass: List Name, Item Text
    static func toggleListItemStatus(listName: String, text: String)
    {
        switch listName {
        case Constants.listsTitleArray[0]:
            toggleStatus(list: &myDay, status: myDay.getStatusOfItem(text: text), text: text)
        case Constants.listsTitleArray[1]:
            toggleStatus(list: &important, status: important.getStatusOfItem(text: text), text: text)
        case Constants.listsTitleArray[2]:
            toggleStatus(list: &planned, status: planned.getStatusOfItem(text: text), text: text)
        case Constants.listsTitleArray[3]:
            toggleStatus(list: &assignedToMe, status: assignedToMe.getStatusOfItem(text: text), text: text)
        case Constants.listsTitleArray[4]:
            toggleStatus(list: &tasks, status: tasks.getStatusOfItem(text: text), text: text)
        default:
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    toggleStatus(list: &optionalLists[i], status: optionalLists[i].getStatusOfItem(text: text), text: text)
                }
            }
            return
        }
    }
    
    //Remove optional List
    static func removeOptionalList(listName: String) -> Bool
    {
        let index = Constants.removeList(listName: listName)
        if index != nil
        {
            let optionalListNames = Constants.getOptionalListTitles()
            
            for i in 0..<optionalListCount
            {
                if optionalListNames[i] == listName
                {
                    optionalLists.remove(at: index!)
                    optionalListCount -= 1
                }
            }
        }
        return false
    }
}






extension ListDataBase
{
    //Private Utility Methods
    
    private static func toggleStatus( list: inout List, status: Bool?, text: String)
    {
        let status = list.getStatusOfItem(text: text)
        if status == nil
        {
            return
        }
        else if status == true
        {
            list.markAsNotDone(text: text)
        }
        else
        {
            list.markAsDone(text: text)
        }
    }
}
