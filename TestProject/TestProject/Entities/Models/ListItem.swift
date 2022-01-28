//
//  ListItem.swift
//  To-Do
//
//  Created by Muhammad Taifoor Saleem on 11/01/2022.
//

import Foundation

struct ListItem
{
    //DATA MEMBERS
    
    private var text:String?
    private var done:Bool?
    
    //END OF DATA MEMBERS
    
    //Recreate a List Item using Properties
    init(text:String, done:Bool)
    {
        self.text = text
        self.done = done
    }
    
    //Create a New List Item
    init(text: String)
    {
        self.text = text
        done = false
    }
    
    //Copy Constructor - No Need but implementing it for some cases
    init(_ other: ListItem)
    {
        self.text = other.text
        self.done = other.done
    }
    
    
    //Mark a Task as Done
    mutating func markDone()
    {
        self.done = true
    }
    
    //Mark a Task as Undone
    mutating func markUndone()
    {
        self.done = false
    }
    
    
    //Change List Item Text
    mutating func changeText(text: String)
    {
        self.text = text
    }
    
    //Returns the Current Status of ListItem
    func isDone() -> Bool?
    {
        return done
    }
    
    //Returns the Current Text in the ListItem
    func getText() -> String?
    {
        return text
    }
}
