//
//  CoreData.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation
import CoreData
import UIKit

class CoreData: ProtocolEntity
{

    //DATA MEMBERS
    let context: NSManagedObjectContext
    
    struct DatabaseConstants
    {
        static let lists = ["listKey", "name", "isPermanent", "activeTaskCount"]
        static let listItems = ["itemKey", "text", "done"]
        static let counter = ["list", "listItem", "group"]
        static let group = ["groupKey", "name"]
    }
    
    //END OF DATA MEMBERS
    
    
    init()
    {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    //MARK: CRUD FUNCTIONALITIES
    
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
    
    
    ///DELETE
    
    
    
    
    
    
    
    
    
    
    func addOptionalList(listName: String) -> Int {
        print("Core >> In addOptionalList")
        return -1
    }
    
    func removeOptionalList(listKey: Int) -> Bool {
        print("Core >> In removeOptionalList")
        return false
    }
    
    func ungroup(groupKey: Int) -> Bool {
        print("Core >> In ungroup")
        return false
    }
    
    func removeGroup(groupKey: Int) -> Bool {
        print("Core >> In removeGroup")
        return false
    }
    
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
        print("Core >> In addListToGroup")
        return false
    }
    
    func removeListFromGroup(listKey: Int) -> Bool {
        print("Core >> In removeListFromGroup")
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
    
    func changeGroupName(groupKey: Int, newGroupName: String) -> Bool {
        print("Core >> In changeGroupName")
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
