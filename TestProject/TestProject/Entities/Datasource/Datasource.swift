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
    
    
    func addGroup(groupName: String) -> Bool {
        let result = plug?.addGroup(groupName: groupName)
        
        if result == nil || result! < 0
        {
            print("Datasource >> addGroup >> Error: CoreData Save Error")
            return false
        }
        else
        {
            return true
        }
        
    }
    
    func addOptionalList(listName: String) -> Bool {
        print("Datasource >> In addOptionalList")
        return false
    }
    
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
        print("Datasource >> In addListToGroup")
        return false
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
        }
        return x ?? true
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
        print("Datasource >> In changeListName")
        return false
    }
    
    func changeGroupName(groupKey: Int, newGroupName: String) -> Bool {
        print("Datasource >> In changeGroupName")
        return false
    }
    
    func ungroup(groupKey: Int) -> Bool {
        print("Datasource >> In ungroup")
        return false
    }
    
    func removeGroup(groupKey: Int) -> Bool {
        print("Datasource >> In removeGroup")
        return false
    }
    
    func deleteList(listKey: Int) -> Bool {
        print("Datasource >> In deleteList")
        return false
    }
    
    func removeListFromGroup(listKey: Int) -> Bool {
        print("Datasource >> In removeListFromGroup")
        return false
    }
    
    
}
