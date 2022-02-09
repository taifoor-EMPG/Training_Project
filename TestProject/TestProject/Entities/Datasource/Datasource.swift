//
//  DataSource.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

class Datasource: ProtocolDatasource
{
    //DATA MEMBERS
    
    private var plug: ProtocolEntity?
    
    //END MEMBERS
    
    init(plugin: ProtocolEntity?)
    {
        guard plugin != nil else
        {
            //SOME ERROR SHOULD POP UP HERE
            plug = nil
            return
        }
        plug = plugin
        loadData()
    }
    
    private func loadData()
    {
        print("Datasource >> In Load Data")
        return
    }
    
    
    func addGroup(groupName: String) -> Int {
        let result = plug?.addGroup(groupName: groupName)
        
        if result == nil || result! < 0
        {
            print("Datasource >> addGroup >> Error: CoreData Save Error")
            return -1
        }
        else
        {
            return result!
        }
        
    }
    
    func addOptionalList(listName: String) -> Int {
        let x = plug?.addOptionalList(listName: listName)
        guard x != nil else
        {
            print("Datasource >> In addOptionalList >> Error: CoreData failed to create list")
            return -1
        }
        return x!
    }
    
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
        let x = plug?.addListToGroup(listKey: listKey, groupKey: groupKey)
        guard x != nil else
        {
            print("Datasource >> In addListToGroup >> Error: CoreData failed to add list to group")
            return false
        }
        return x!
    }
    
    func getPermanentListTitles() -> [Int : String]? {
        
        let lists = plug?.getPermanentListTitles()
        
        guard lists != nil else
        {
            print("Datasource >> getPermanentListTitles >> Error: CoreData returned Empty")
            return nil
        }
        
        var toReturn = [Int:String]()
        
        for i in lists!
        {
            toReturn[Int(i.listKey)] = i.name
        }
        
        return toReturn
    }
    
    func getActiveItems(listKey: Int) -> Int {
        
        let list = plug?.getActiveItems(listKey: listKey)
        
        guard list != nil else
        {
            print("Datasource >> getActiveItems >> Error: CoreData Could Not Find List ")
            return -1
        }
        
        return Int(exactly: list![0].activeTaskCount)!
    }
    
    func getGroups() -> [Group] {
        let groups = plug?.getGroups()
        
        guard groups?.isEmpty != true else
        {
            print("Datasource >> getGroups >> Error: CoreData Could Not Find List ")
            return []
        }
        
        return groups!
    }
    
    func getGroupFreeListTitles() -> [Int : String]? {
        
        let lists = plug?.getOptionalListTitles()
        
        guard lists != nil else
        {
            print("Datasource >> getGroupFreeListTitles >> Error: CoreData returned Empty")
            return nil
        }
        
        var toReturn = [Int:String]()
        
        for i in lists!
        {
            if i.group == nil
            {
                toReturn[Int(i.listKey)] = i.name
            }
        }
        
        return toReturn
    }
    
    func getGroupCount() -> Int {
        let x = plug?.getGroupsCount()
        if x == -1
        {
            print("Datasource >> In getGroupCount >> Error: Failed to Retrieve Count")
        }
        return x ?? -1
    }
    
    func groupExists(groupName: String) -> Bool {
        
        let x = plug?.groupExists(groupName: groupName)
        
        if x == nil
        {
            print("Datasource >> In groupExists >> Error: Failed to Retrieve Count")
            return true
        }
        return x!
    }
    
    func listExists(listName: String) -> Bool {
        let x = plug?.listExists(listName: listName)
        
        if x == nil
        {
            print("Datasource >> In listExists >> Error: Failed to Retrieve Count")
            return true
        }
        return x!
    }
    
    
    func getGroupTitles(groupKey: Int) -> [Int : String] {
        print("Datasource >> In getGroupCount")
        return [:]
    }
    
    func getGroupSize(GroupKey: Int) -> Int {
        print("Datasource >> In getGroupSize")
        return -1
    }
    
    func getGroupListTitles(groupKey: Int) -> [Int : String]? {
        print("Datasource >> In getGroupListTitles")
        return nil
    }
    
    func changeListName(listKey: Int, newListName: String) -> Bool {
        let x = plug?.changeListName(listKey: listKey, newListName: newListName)
        if x == nil || x == false
        {
            print("In Datasouce >> changeListName >> ERROR")
            return false
        }
        return true
    }
    
    func changeGroupName(groupKey: Int, newGroupName: String) -> Bool {
        let x = plug?.changeGroupName(groupKey: groupKey, newGroupName: newGroupName)
        if x == nil || x == false
        {
            print("In Datasouce >> changeGroupName >> ERROR")
            return false
        }
        return true
    }
    
    func ungroup(groupKey: Int) -> Bool {
        let x = plug?.ungroup(groupKey: groupKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    func removeGroup(groupKey: Int) -> Bool {
        let x = plug?.removeGroup(groupKey: groupKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    func deleteList(listKey: Int) -> Bool {
        let x = plug?.removeOptionalList(listKey: listKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool {
        let x = plug?.removeListFromGroup(listKey: listKey, groupKey: groupKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    
    func getList(listKey: Int) -> List? {
        let x = plug?.getList(listKey: listKey)
        if x == nil
        {
            print("In DataSource >> getList >> Error: Failed to Fetch")
            return nil
        }
        return x
    }
    
    func allowEditing(listKey: Int) -> Bool? {
        let x = plug?.allowEditing(listKey: listKey)
        if x == nil
        {
            print("In DataSource >> allowEditing >> Error: Failed to Fetch")
            return nil
        }
        return x
    }
    
    func changeStatusOfItem(itemKey: Int, newStauts: Bool) {
        let x = plug?.mark(listItemKey: itemKey, newStatus: newStauts)
        if x == nil || x == false
        {
            print("In DataSource >> changeStatusOfItem >> Error: Failed to Fetch")
        }
    }
    
    func changeTextOfItem(itemKey: Int, newText: String) {
        let x = plug?.changeTextOfItem(itemKey: itemKey, newText: newText)
        if x == nil || x == false
        {
            print("In DataSource >> changeStatusOfItem >> Error: Failed to Fetch")
        }
    }
    
    func addItemtoList(listKey: Int, itemText: String) -> Bool {
        let x = plug?.addItemtoList(listKey: listKey, itemText: itemText)
        if x == nil || x! < 0
        {
            print("In DataSource >> addItemtoList >> Error: Failed to Fetch")
            return false
        }
        return true
    }
    
    func removeItemFromList(listKey: Int, itemKey: Int) -> Bool {
        let x = plug?.removeItemFromList(listKey: listKey, itemKey: itemKey)
        if x == nil || x! == false
        {
            print("In DataSource >> addItemtoList >> Error: Failed to Fetch")
            return false
        }
        return true
    }
}
