//
//  ProtocolsEntity.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 27/01/2022.
//

import Foundation

//Refer to To-Do List DB Requisitions

protocol ProtocolEntity
{
    //Get Permanent Lists
    //Return: Dictionary [List] (nil on failure)
    func getPermanentListTitles() -> [List]?
    
    //Get Active Items of a List
    //Return: Said List as array on Sucess (-1 on failure)
    func getActiveItems(listKey: Int) -> [List]?
    
    //Get Group Count
    //Return: Count on Success (-1 on failure)
    func getGroupsCount() -> Int
    
    //Get Optional Lists
    //Return: Dictionary [List] (nil on failure)
    func getOptionalListTitles() -> [List]?
    
    //Does a group with given name exist?
    //Return: Result of Operation
    func groupExists(groupName: String) -> Bool?
    
    //Adds a New Optional List
    //Return: listKey on Success (-1 on failure)
    func addOptionalList(listName: String) -> Int
    
    //Removes an Optional List
    //Return: Result of Operation
    func removeOptionalList(listKey: Int) -> Bool

    //Add Group
    //Return: groupKey on Sucess (-1 on failure)
    func addGroup(groupName: String) -> Int
    
    //Ungroup - Release all Lists from the Group
    //Return: Result of Operation
    func ungroup(groupKey: Int) -> Bool
    
    //Remove Group
    //Return: Result of Operation
    func removeGroup(groupKey: Int) -> Bool

    //Add List to Group
    //Return: Result of Operation
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool
    
    //Remove List from Group
    //Return: Result of Operation
    func removeListFromGroup(listKey: Int) -> Bool
    
    //Add Item to List
    //Return: listItemKey on Success (-1 on failure)
    func addItemtoList(listKey: Int, itemText: String) -> Int
    
    //Remove Item from List
    //Return: Result of Operation
    func removeItemFromList(listKey: Int, itemKey: Int) -> Bool
    
    //Marks Item as Done/Undone
    //Return: Result of Operation
    func mark(listItemKey: Int) -> Bool

    //Gets Total Size of a List
    //Return: Size on Success (-1 on failure)
    func getListSize(listKey: Int) -> Int
    

    
    //Change Name of List
    //Return: Result of Operation
    func changeListName(listKey: Int, newListName: String) -> Bool
    
    //Change Text of List Item
    //Return: Result of Operation
    func changeTextOfItem(itemKey: Int, newText: String) -> Bool

    //Change Name of Group
    //Return: Result of Operation
    func changeGroupName(groupKey: Int, newGroupName: String) -> Bool
    
    //Get List Item Array for a given List
    //Return: Dictionary [itemKey: <text, bool>] on Success ([] on failure)
    func getListItems(listkey: Int) -> [Int: (text: String, status: Bool)]
    
    //Get Lists
    //Return: Dictionary [listKey: listName] on Success ([] on failure)
    func getLists() -> [Int: String]
    
    //Get Groups
    //Return: Dictionary [groupKey: [Array of Lists]] on Success ([] on failure)
    func getGroups() -> [Group]
    
    //Get Group Size
    //Return: Size on Success (-1 on failure)
    func getGroupSize(groupKey: Int) -> Int
    

}
