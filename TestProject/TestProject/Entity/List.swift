//
//  List.swift
//  To-Do
//
//  Created by Muhammad Taifoor Saleem on 11/01/2022.
//

import Foundation

struct List
{
    //DATA MEMBERS
    
    private var items: [ListItem] = []
    private var size = 0
   
    //END OF DATA MEMBERS
    
    //Default Constructor
    init()
    {
       items = []
       size = 0
    }

    //Recreate a List using ListItems
    init(list: [ListItem])
    {
        for i in list
        {
            items.append(ListItem(i))
        }
        size = items.count
    }
    
    
    //Get List Size as a STRING to Display/Print
    func getListSize() -> String
    {
        if size == 0
        {
            return ""
        }
        else
        {
            return String(format: "%d", size)
        }
    }
    
    //Get List Size
    func getListSize() -> Int
    {
        return size
    }
    
    //Get Status of Item
    func getStatusOfItem(text: String) -> Bool?
    {
        for i in items
        {
            if i.getText() == text
            {
                return i.isDone()!
            }
        }
        return nil
    }
    
    //Add an Item to the List
    mutating func addItemToList(text: String)
    {
        items.append(ListItem(text: text))
        size += 1
    }
    
    
    //Remove an Item from List
    mutating func removeItemFromList(text: String) -> Bool
    {
        var index = 0
        for i in items
        {
            if i.getText() == text
            {
                items.remove(at: index)
                return true
            }
            index += 1
        }
        return false
    }
    
    //Change text of an item
    mutating func alterItem(oldText: String, newText: String) -> Bool
    {
        var index = 0
        for var i in items
        {
            if i.getText() == oldText
            {
                i.changeText(text: newText)
                return true
            }
            index += 1
        }
        return false
    }
    
    //Mark an Item as Done
    mutating func markAsDone(text: String)
    {
        var index = 0
        for var i in items
        {
            if i.getText() == text
            {
                i.markDone()
            }
            index += 1
        }
    }
    
    //Mark an Item as Not Done
    mutating func markAsNotDone(text: String)
    {
        var index = 0
        for var i in items
        {
            if i.getText() == text
            {
                i.markUndone()
            }
            index += 1
        }
    }

//Get List Item Text - Array
    func getListItemsText() -> [String]
    {
        var toReturn:[String] = []
        for i in items
        {
            toReturn.append(i.getText()!)
        }
        return toReturn
    }
    
    
    //Get List Item Status - Array
    func getListItemStauts() -> [Bool]
    {
        var toReturn:[Bool] = []
        for i in items
        {
            toReturn.append(i.isDone()!)
        }
        return toReturn
    }
}

