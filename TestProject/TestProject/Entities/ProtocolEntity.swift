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
    //Adds a New Optional List
    //Return: listKey on Success (-1 on failure)
    func addOptionalList(listName: String) -> Int
    
    //Removes an Optional List
    //Return: Result of Operation
    func removeOptionalList(listKey: Int) -> Bool

    //Add Group
    //Returns: groupKey on Sucess (-1 on failure)
    func addGroup(groupName: String) -> Int

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
    
    //Get Active Items of a List
    //Return: Count of Active Items on Sucess (-1 on failure)
    func getActiveItems(listKey: Int) -> Int
    
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
    func getGroups() -> [Int: [Int]]
    
    //Get Group Size
    //Return: Size on Success (-1 on failure)
    func getGroupSize(groupKey: Int) -> Int
    
    //Get Group Count
    //Return: Count on Success (-1 on failure)
    func getGroupsCount() -> Int
}
