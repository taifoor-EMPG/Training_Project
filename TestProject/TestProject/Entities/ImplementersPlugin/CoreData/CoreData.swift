//
//  CoreData.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import CoreData
import UIKit

class CoreData: ProtocolEntity
{
    //MARK: DATA MEMBERS
    private let context: NSManagedObjectContext
    private let manager: CoreDataManagerProtocol
  
    struct DatabaseConstants
    {
        static let lists = ["listKey", "name", "isPermanent", "activeTaskCount"]
        static let listItems = ["itemKey", "text", "done"]
        static let counter = ["list", "listItem", "group"]
        static let group = ["groupKey", "name"]
    }
    
    //END OF DATA MEMBERS
    
  
  //Initializer to Instantiate Core Data Class
  init(CoreDataManager: CoreDataManagerProtocol = CoreDataManager.shared)
    {
      self.manager = CoreDataManager
      context = manager.persistentContainer.viewContext
    }
    
  
  
  //MARK: CRUD FUNCTIONALITIES
  ///Refer to ProtocolDataSource for implementational details
  
  
  ///CREATE
    func addGroup(groupName: String) -> Int
    {
        do
        {
            let request = Counters.fetchRequest() as NSFetchRequest<Counters>
            let counter = try context.fetch(request)
            
            let key = counter[0].group            
            counter[0].group += 1
            
            let mygroup = Group(context: context)
            mygroup.groupKey = key
            mygroup.name = groupName
                    
            try self.context.save()
            return Int(key)
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getPermanentListTitles >> Failed to Fetch")
            return -1
        }
    }
    
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
        do
        {
            let requestGroup = Group.fetchRequest() as NSFetchRequest<Group>
            let predicateGroup = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
            requestGroup.predicate = predicateGroup
            
            let group = try context.fetch(requestGroup)
            
            if group.isEmpty == true
            {
                return false
            }
            
            let requestList = List.fetchRequest() as NSFetchRequest<List>
            let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            requestList.predicate = predicateList
            
            let lists = try context.fetch(requestList)
            
            if lists.isEmpty == true
            {
                return false
            }
            
            
            group[0].addToLists(lists[0])
            
            try self.context.save()
            return true
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("Core >> In addListToGroup")
            return false
        }
    }
    
    
    ///READ
    func getPermanentListTitles() -> [List]? {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[2] + " == true")
            request.predicate = predicate
            
            let sort = NSSortDescriptor(key: DatabaseConstants.lists[0], ascending: true)
            request.sortDescriptors = [sort]
            
            let lists = try context.fetch(request)
            
            return lists
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getPermanentListTitles >> Failed to Fetch")
            return nil
        }
    }
    
    func getOptionalListTitles() -> [List]? {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[2] + " == false")
            request.predicate = predicate
            
            let sort = NSSortDescriptor(key: DatabaseConstants.lists[0], ascending: true)
            request.sortDescriptors = [sort]
            
            let lists = try context.fetch(request)
            
            return lists
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getPermanentListTitles >> Failed to Fetch")
            return nil
        }
    }
    
    
    func getActiveItems(listKey: Int) -> [List]? {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            request.predicate = predicate
            
            let list = try context.fetch(request)
            
            return list
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getPermanentListTitles >> Failed to Fetch")
            return nil
        }
    }
    
    func getGroupsCount() -> Int {
        do
        {
            let request = Group.fetchRequest() as NSFetchRequest<Group>
            let groups = try context.fetch(request)
            return groups.count
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getGroupsCount >> Failed to Fetch")
            return -1
        }
    }
    
    func getGroups() -> [Group]
    {
        do
        {
            let request = Group.fetchRequest() as NSFetchRequest<Group>
            let groups = try context.fetch(request)
            return groups
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getGroups >> Failed to Fetch")
            return []
        }
    }
    
    func groupExists(groupName: String) -> Bool? {
        do
        {
            let request = Group.fetchRequest() as NSFetchRequest<Group>
            let predicate = NSPredicate(format: DatabaseConstants.group[1] + " == '" + String(groupName) + "'")
            request.predicate = predicate
            
            let group = try context.fetch(request)
            
            let x = !group.isEmpty
            return x
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getPermanentListTitles >> Failed to Fetch")
            return nil
        }
    }
    
    
    
    ///UPDATE
    func changeGroupName(groupKey: Int, newGroupName: String) -> Bool {
        do
        {
            let request = Group.fetchRequest() as NSFetchRequest<Group>
            let predicate = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
            request.predicate = predicate
            
            let group = try context.fetch(request)
            
            if group.isEmpty == true
            {
                return false
            }
            
            group[0].name = newGroupName
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func changeGroupName >> Failed to Fetch")
            return false
        }
    }
    
    ///DELETE
    func removeGroup(groupKey: Int) -> Bool {
        do
        {
            let request = Group.fetchRequest() as NSFetchRequest<Group>
            let predicate = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
            request.predicate = predicate
            
            let group = try context.fetch(request)
            
            if group.isEmpty == true
            {
                return false
            }
            
            self.context.delete(group[0])
            
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func changeGroupName >> Failed to Fetch")
            return false
        }
    }
    
    func ungroup(groupKey: Int) -> Bool {
        do
        {
            let requestGroup = Group.fetchRequest() as NSFetchRequest<Group>
            let predicateGroup = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
            requestGroup.predicate = predicateGroup
            
            let group = try context.fetch(requestGroup)
            
            if group.isEmpty == true
            {
                return false
            }
            
            let requestList = List.fetchRequest() as NSFetchRequest<List>
            let predicateList = NSPredicate(format: DatabaseConstants.lists[2] + " == false")
            requestList.predicate = predicateList
            
            let lists = try context.fetch(requestList)
            
            for i in lists
            {
                if i.group == nil
                {
                    //print("List " + i.name! + " not a part of any group")
                }
                else
                {
                    if  Int(i.group!.groupKey) == groupKey
                    {
                        group[0].removeFromLists(i)
                    }
                }
            }
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func ungroup >> Failed to Transact")
            return false
        }
    }
    
    func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool {
        do
        {
            let requestGroup = Group.fetchRequest() as NSFetchRequest<Group>
            let predicateGroup = NSPredicate(format: DatabaseConstants.group[0] + " == " + String(groupKey))
            requestGroup.predicate = predicateGroup
            
            let group = try context.fetch(requestGroup)
            
            if group.isEmpty == true
            {
                return false
            }
            
            let requestList = List.fetchRequest() as NSFetchRequest<List>
            let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            requestList.predicate = predicateList
            
            let lists = try context.fetch(requestList)
            
            if lists.isEmpty == true
            {
                return false
            }
            
            
            group[0].removeFromLists(lists[0])
            
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("Core >> In removeListFromGroup")
            return false
        }
    }
    
    
    
    
    
    
    
    
    func addOptionalList(listName: String) -> Int {
        print("Core >> In addOptionalList")
        return -1
    }
    
    func removeOptionalList(listKey: Int) -> Bool {
        print("Core >> In removeOptionalList")
        return false
    }
    
    func addItemtoList(listKey: Int, itemText: String) -> Int {
        print("Core >> In addItemtoList")
        return -1
    }
    
    func removeItemFromList(listKey: Int, itemKey: Int) -> Bool {
        print("Core >> In removeItemFromList")
        return false
    }
    
    func mark(listItemKey: Int) -> Bool {
        print("Core >> In mark")
        return false
    }
    
    func getListSize(listKey: Int) -> Int {
        print("Core >> In getListSize")
        return -1
    }
    
    func changeListName(listKey: Int, newListName: String) -> Bool {
        print("Core >> In changeListName")
        return false
    }
    
    func changeTextOfItem(itemKey: Int, newText: String) -> Bool {
        print("Core >> In changeTextOfItem")
        return false
    }
    
    func getListItems(listkey: Int) -> [Int : (text: String, status: Bool)] {
        print("Core >> In getListItems")
        return [:]
    }
    
    func getLists() -> [Int : String] {
        print("Core >> In getLists")
        return [:]
    }
    
    func getGroups() -> [Int : [Int]] {
        print("Core >> In getGroups")
        return [:]
    }
    
    func getGroupSize(groupKey: Int) -> Int {
        print("Core >> In getPermanentListTitles")
        return -1
    }
}
