//
//  ProtocolDatasource.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

protocol ProtocolDatasource
{
    //MARK: CRUD - CREATE
    
    //Add Group
    //Return: Result of Operation
    func addGroup(groupName: String) -> Bool
    
    //Adds a New Optional List
    //Return: Result of Operation
    func addOptionalList(listName: String) -> Bool
    
    //Add List to Group
    //Return: Result of Operation
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool
    
    
    
    //MARK: CRUD - READ
    
    //Get Permanent List Titles
    //Return: Dictionary of [listKey: listTitle] (NIL on failure)
    func getPermanentListTitles() -> [Int : String]?
    
    //Get Count Active Items of a List
    //Return: Count of Active Items on Sucess (-1 on failure)
    func getActiveItems(listKey: Int) -> Int
    
    //Get Count of Non-Grouped Lists
    //Return: Dictionary of [listKey: listTitle] (NIL on failure)
    func getGroupFreeListTitles() -> [Int : String]?
    
    //Get Group Count
    //Return: Total Number of Groups on Success (-1 on failure)
    func getGroupCount() -> Int
    
    //Get List Titles in a Group
    //Return: Dictionary of [listKey: listTitle] (NIL on failure)
    func getGroupTitles(groupKey: Int) -> [Int : String]
    
    //Gets Total Size of a Group
    //Return: Size on Success (-1 on failure)
    func getGroupSize(GroupKey: Int) -> Int
    
    //Get Group List Titles
    //Return: Dictionary of [listKey: listTitle] (NIL on failure)
    func getGroupListTitles(groupKey: Int) -> [Int : String]?
    
    
    //Find A Group
    //Returns: Result of Operation
    func groupExists(groupName: String) -> Bool
    
    //MARK: CRUD - UPDATE
    
    //Change Name of List
    //Return: Result of Operation
    func changeListName(listKey: Int, newListName: String) -> Bool
    
    //Change Name of Group
    //Return: Result of Operation
    func changeGroupName(groupKey: Int, newGroupName: String) -> Bool
    
    //Ungroup - Release all Lists from the Group
    //Return: Result of Operation
    func ungroup(groupKey: Int) -> Bool
    
    
    //MARK: CRUD - DELETE
    
    //Remove Group
    //Return: Result of Operation
    func removeGroup(groupKey: Int) -> Bool

    //Removes an Optional List
    //Return: Result of Operation
    func deleteList(listKey: Int) -> Bool
    
    //Remove List from Group
    //Return: Result of Operation
    func removeListFromGroup(listKey: Int) -> Bool
    
    
    
    //MARK: - PROCESSED TILL HERE
    ///Remaining functions are left to process
    
    //Add Item to List
    //Return: listItemKey on Success (-1 on failure)
    //func addItemtoList(list: List, itemText: String) -> Int
    
    //Remove Item from List
    //Return: Result of Operation
    //func removeItemFromList(list: List, item: ListItem) -> Bool
    
    //Marks Item as Done/Undone
    //Return: Result of Operation
    //func mark(list: List, listItem: ListItem) -> Bool
    
    //Gets Total Size of a List
    //Return: Size on Success (-1 on failure)
    //func getListSize(listKey: Int) -> Int
    
    //Change Text of List Item
    //Return: Result of Operation
    //func changeTextOfItem(itemKey: Int, newText: String) -> Bool
    
    //Get List Item Array for a given List
    //Return: Dictionary [itemKey: <text, bool>] on Success ([] on failure)
    //func getListItems(listkey: Int) -> [Int: (text: String, status: Bool)]
    
    //Get Lists
    //Return: Dictionary [listKey: listName] on Success ([] on failure)
    //func getLists() -> [Int: String]
    
    //Get Groups
    //Return: [Grouping] on Success ([] on failure)
    func getGroups() -> [Group]
    
}
