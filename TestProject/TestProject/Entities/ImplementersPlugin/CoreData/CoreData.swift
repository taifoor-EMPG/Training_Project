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
    
    func addOptionalList(listName: String) -> Int {
        do
        {
            let request = Counters.fetchRequest() as NSFetchRequest<Counters>
            let counter = try context.fetch(request)
            
            let key = counter[0].list
            counter[0].list += 1
            
            let newList = List(context: context)
            newList.newList(listKey: Int(key), name: listName, isPermanent: false)
            
            try self.context.save()
            return Int(key)
            
        }
        catch
        {
            //Error Failed to Fetch Data
            print("Core >> In addOptionalList >> ERROR: Failed to create List")
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
    
    func addItemtoList(listKey: Int, itemText: String) -> Int {
        do
        {
            let requestList = List.fetchRequest() as NSFetchRequest<List>
            let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            requestList.predicate = predicateList
            
            let list = try context.fetch(requestList)
            
            if list.isEmpty == true
            {
                return -1
            }
            
            let requestCounters = Counters.fetchRequest() as NSFetchRequest<Counters>
            let counter = try context.fetch(requestCounters)
            
            if counter.isEmpty == true
            {
                return -1
            }
            
            let key = counter[0].listItem
            counter[0].list += 1
            
            let newListItem = ListItem(context: context)
            newListItem.itemKey = key
            newListItem.text = itemText
            newListItem.done = false
            
            list[0].addToListItems(newListItem)
            
            try self.context.save()
            return Int(key)
        }
        catch
        {
            //Error Failed to Fetch Data
            print("Core >> In addItemtoList >> ERROR")
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
    
    func listExists(listName: String) -> Bool? {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[1] + " == '" + String(listName) + "'")
            request.predicate = predicate
            
            let list = try context.fetch(request)
            
            let x = !list.isEmpty
            return x
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func listExists >> Failed to Fetch")
            return nil
        }
    }
    
    func getList(listKey: Int) -> List? {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            request.predicate = predicate
            
            let list = try context.fetch(request)
            
            if list.isEmpty == true
            {
                return nil
            }
            
            return list[0]
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func getList >> Failed to Fetch")
            return nil
        }
    }
    
    func allowEditing(listKey: Int) -> Bool? {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            request.predicate = predicate
            
            let list = try context.fetch(request)
            
            if list.isEmpty == true
            {
                return nil
            }
            
            return !list[0].isPermanent
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func allowEditing >> Failed to Fetch")
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
    
    func changeListName(listKey: Int, newListName: String) -> Bool {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            request.predicate = predicate
            
            let list = try context.fetch(request)
            
            if list.isEmpty == true
            {
                return false
            }
            
            list[0].name = newListName
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
    
    
    func mark(listItemKey: Int, newStatus: Bool) -> Bool {
        do
        {
            let request = ListItem.fetchRequest() as NSFetchRequest<ListItem>
            let predicate = NSPredicate(format: DatabaseConstants.listItems[0] + " == " + String(listItemKey))
            request.predicate = predicate
            
            let listItem = try context.fetch(request)
            
            if listItem.isEmpty == true
            {
                return false
            }
            
            listItem[0].done = newStatus
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func mark >> Failed to Fetch")
            return false
        }
    }
    
    func changeTextOfItem(itemKey: Int, newText: String) -> Bool {
        do
        {
            let request = ListItem.fetchRequest() as NSFetchRequest<ListItem>
            let predicate = NSPredicate(format: DatabaseConstants.listItems[0] + " == " + String(itemKey))
            request.predicate = predicate
            
            let listItem = try context.fetch(request)
            
            if listItem.isEmpty == true
            {
                return false
            }
            
            listItem[0].text = newText
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("ERROR: In Datasource >> func mark >> Failed to Fetch")
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
    
    func removeOptionalList(listKey: Int) -> Bool {
        do
        {
            let request = List.fetchRequest() as NSFetchRequest<List>
            let predicate = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            request.predicate = predicate
            
            let list = try context.fetch(request)
            
            if list.isEmpty == true
            {
                return false
            }
            
            self.context.delete(list[0])
            
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("Core >> In removeOptionalList >> Failed to Fetch Data")
            return false
        }
    }
    
    func removeItemFromList(listKey: Int, itemKey: Int) -> Bool {
        do
        {
            let requestList = List.fetchRequest() as NSFetchRequest<List>
            let predicateList = NSPredicate(format: DatabaseConstants.lists[0] + " == " + String(listKey))
            requestList.predicate = predicateList
            
            let list = try context.fetch(requestList)
            
            if list.isEmpty == true
            {
                return false
            }
            
            let requestListItem = ListItem.fetchRequest() as NSFetchRequest<ListItem>
            let predicateListItem = NSPredicate(format: DatabaseConstants.listItems[0] + " == " + String(itemKey))
            requestListItem.predicate = predicateListItem
            
            let listsItem = try context.fetch(requestListItem)
            
            if listsItem.isEmpty == true
            {
                return false
            }
            
            list[0].removeFromListItems(listsItem[0])
            
          self.context.delete(listsItem[0])
          
            try self.context.save()
            return true
        }
        catch
        {
            //Error Failed to Fetch Data
            print("Core >> In removeItemFromList")
            return false
        }
    }
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    func getListSize(listKey: Int) -> Int {
        print("Core >> In getListSize")
        return -1
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
