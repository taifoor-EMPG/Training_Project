//
//  ProtocolsEntity.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 27/01/2022.
//

import Foundation

//Refer to To-Do List DB Requisitions

protocol ProtocolDataSource
{
  
  //MARK: CREATE OPERTAION
  
  //Add Group
  //Return: groupKey on Sucess (-1 on failure)
  func addGroup(groupName: String) -> Int
  
  //Adds a New Optional List
  //Return: listKey on Success (-1 on failure)
  func addOptionalList(listName: String) -> Int
  
  //Add List to Group
  //Return: Result of Operation
  func addListToGroup(listKey: Int, groupKey: Int) -> Bool
  
  //Add Item to List
  //Return: listItemKey on Success (-1 on failure)
  func addItemtoList(listKey: Int, itemText: String) -> Int
  
  
  //MARK: READ OPERATIONS
  
  //Get Permanent Lists
  //Return: Dictionary [List] (nil on failure)
  func getPermanentListTitles(completion: @escaping (([List]?) -> Void))
  
  //Get Optional Lists
  //Return: Dictionary [List] (nil on failure)
  func getOptionalListTitles(completion: @escaping (([List]?) -> Void))
  
  //Get Active Items of a List
  //Return: Said List as array on Sucess (-1 on failure)
  func getActiveItems(listKey: Int, completion: @escaping (([List]?) -> Void))
  
  //Get Group Count
  //Return: Count on Success (-1 on failure)
  func getGroupsCount(completion: @escaping ((Int) -> Void))
  
  //Get Group Count
  //Return: Count on Success (-1 on failure)
  func getGroups(completion: @escaping (([Group]) -> Void))
  
  //Does a group with given name exist?
  //Return: Result of Operation
  func groupExists(groupName: String, completion: @escaping ((Bool) -> Void))
  
  //Does a list with given name exist?
  //Return: Result of Operation
  //<PLACE HOLDER> func listExists(listName: String) -> Bool?
  
  //Gets Total Size of a List
  //Return: Size on Success (-1 on failure)
  //<PLACE HOLDER> func getList(listKey: Int) -> List?
  
  //Know if the list is Permanent
  //Returns result of operations (nil on failure)
  //<PLACE HOLDER> func allowEditing(listKey: Int) -> Bool?
  
  // --> RECHECK THESE FUNCTIONS
  func listExists(listName: String) -> Bool?
  func getList(listKey: Int) -> List?
  func allowEditing(listKey: Int) -> Bool?
  // --> Till Here
  
  //Search through List and Items for a String
  //Returns [Result] on Sucess (nil on Failure)
  func search(query: String, completion: @escaping ([Results]?) -> Void)
  
  
  //MARK: UPDATE OPERATIONS
  
  //Change Name of Group
  //Return: Result of Operation
  func changeGroupName(groupKey: Int, newGroupName: String) -> Bool
  
  //Change Name of List
  //Return: Result of Operation
  func changeListName(listKey: Int, newListName: String) -> Bool
  
  //Marks Item as Done/Undone
  //Return: Result of Operation
  func mark(listItemKey: Int, newStatus: Bool) -> Bool
  
  //Change Text of List Item
  //Return: Result of Operation
  func changeTextOfItem(itemKey: Int, newText: String) -> Bool
  
  
  //MARK: DELETE OPERATIONS
  
  //Remove Group
  //Return: Result of Operation
  func removeGroup(groupKey: Int) -> Bool
  
  //Removes an Optional List
  //Return: Result of Operation
  func removeOptionalList(listKey: Int) -> Bool
  
  //Ungroup - Release all Lists from the Group
  //Return: Result of Operation
  func ungroup(groupKey: Int) -> Bool
  
  //Remove List from Group
  //Return: Result of Operation
  func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool
  
  //Remove Item from List
  //Return: Result of Operation
  func removeItemFromList(listKey: Int, itemKey: Int) -> Bool
}
