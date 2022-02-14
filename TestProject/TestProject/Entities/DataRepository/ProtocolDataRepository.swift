//
//  ProtocolDatasource.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

protocol ProtocolDataRepository
{
  //MARK: CRUD - CREATE
  
  //Add Group
  //Return: Result of Operation
  func addGroup(groupName: String) -> Int
  
  //Adds a New Optional List
  //Return: Result of Operation
  func addOptionalList(listName: String) -> Int
  
  //Add List to Group
  //Return: Result of Operation
  func addListToGroup(listKey: Int, groupKey: Int) -> Bool
  
  //Add Item to List
  //Return: Result of Operation
  func addItemtoList(listKey: Int, itemText: String) -> Bool
  
  
  //MARK: CRUD - READ
  
  //Get Permanent List Titles
  //Return: Dictionary of [listKey: listTitle] (NIL on failure)
  func getPermanentListTitles(completion: @escaping (([Int : String]?) -> Void))
  
  //Get Count Active Items of a List
  //Return: Count of Active Items on Sucess (-1 on failure)
  func getActiveItems(listKey: Int, completion: @escaping ((Int) -> Void))
  
  //Get All Groups
  //Return [Groups]? on Success (nil on Failure)
  func getGroups(completion: @escaping (([Group]) -> Void))
  
  //Get Count of Non-Grouped Lists
  //Return: Dictionary of [listKey: listTitle] (NIL on failure)
  func getGroupFreeListTitles(completion: @escaping (([Int : String]?) -> Void))
  
  //Get Group Count
  //Return: Total Number of Groups on Success (-1 on failure)
  func getGroupCount(completion: @escaping ((Int) -> Void))
  
  //Find A Group
  //Returns: Result of Operation
  func groupExists(groupName: String, completion: @escaping ((Bool) -> Void))
  
  //Search a Query
  //Returns: [Results] on Success (nil on Failure)
  func searchQuery(query: String, completion: @escaping (([Results]?) -> Void))
  
  //Find A List
  //Returns: Result of Operation
  func listExists(listName: String, completion: @escaping ((Bool) -> Void))
  
  //Know if the list is Permanent
  //Returns result of operations (nil on failure)
  func allowEditing(listKey: Int, completion: @escaping ((Bool) -> Void))
  
  //Get a Particular List
  //Returns a List on Success (nil on Failure)
  func getList(listKey: Int, completion: @escaping ((List?) -> Void))
  
  //MARK: CRUD - UPDATE
  
  //Change Name of List
  //Return: Result of Operation
  func changeListName(listKey: Int, newListName: String) -> Bool
  
  //Change Name of Group
  //Return: Result of Operation
  func changeGroupName(groupKey: Int, newGroupName: String) -> Bool
  
  //Change Status of ListItem
  //Return: NA
  func changeStatusOfItem(itemKey: Int, newStauts: Bool)
  
  //Change Text of ListItem
  //Return: NA
  func changeTextOfItem(itemKey: Int, newText: String)
  
  
  //MARK: CRUD - DELETE
  
  //Ungroup - Release all Lists from the Group
  //Return: Result of Operation
  func ungroup(groupKey: Int) -> Bool
  
  //Remove Group
  //Return: Result of Operation
  func removeGroup(groupKey: Int) -> Bool
  
  //Removes an Optional List
  //Return: Result of Operation
  func deleteList(listKey: Int) -> Bool
  
  //Remove List from Group
  //Return: Result of Operation
  func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool
  
  //Remove Item from List
  //Return: Result of Operation
  func removeItemFromList(listKey: Int, itemKey: Int) -> Bool
  
}
