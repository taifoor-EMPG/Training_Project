//
//  PopulateMenuInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/01/2022.
//

import Foundation

//MARK: - All Methods that the Presenter can call to get information from API/DB come here
class PopulateMenuInteractor: ProtocolPresenterToInteractorPopulateMenu
{
    //Data Members
    
    private weak var presenter: ProtocolInteractorToPresenterPopulateMenu?
    private var source: ProtocolDatasource?
    
    //End of Data Members
    
    
    init(source : ProtocolDatasource?)
    {
        guard source != nil else
        {
            //RAISE SOME ERROR HERE
            return
        }
        self.source = source
    }

    func setPresenter(presenter: ProtocolInteractorToPresenterPopulateMenu?)
    {
        guard presenter != nil else
        {
            //RAISE SOME ERROR HERE
            return
        }
        self.presenter = presenter
    }
    
    //MARK: CRUD - CREATE
    func createGroup(groupName: String) -> Int {
        
        //Check if group with same name exists
        
        var name = groupName
        var count = 1
        var result = source?.groupExists(groupName: name)
        
        while result == true
        {
            name = groupName + " " + String(count)
            result = source?.groupExists(groupName: name)
            count += 1
        }
        
        let key = source?.addGroup(groupName: name)
        if key == nil
        {
            print("PopulateMenuInteractor >> In createGroup >> Error: Failed to Perform")
            return key ?? -1
        }
        return key!
    }
    
    func createList(listName: String) -> (Int, String) {
        
        var name = listName
        var count = 1
        var result = source?.listExists(listName: listName)
        
        while result == true
        {
            name = Utilities.newList() + "(" + String(count) + ")"
            result = source?.listExists(listName: listName)
            count += 1
        }
        
        let key = source?.addOptionalList(listName: name)
        return (key!, name)
    }
    
    func addListToGroup(listKey: Int, groupKey: Int) -> Bool {
        let x = source?.addListToGroup(listKey: listKey, groupKey: groupKey)
        if x == nil
        {
            print("PopulateMenuInteractor >> In addListToGroup >> Error: Failed to Add List")
        }
        return x ?? false
    }
    
    //MARK: CRUD - READ
    func getPermanentListTitles() -> [Int : String] {
        let x = source?.getPermanentListTitles()
        if x == nil
        {
            print("PopulateMenuInteractor >> In getPermanentListTitles >> Error: Failed to Retrieve Count")
        }
        return x ?? [:]
    }
    
    func getListActiveCount(listKey: Int) -> Int {
        let x = source?.getActiveItems(listKey: listKey)
        if x == -1
        {
            print("PopulateMenuInteractor >> In getListActiveCount >> Error: Failed to Retrieve Count")
        }
        return x ?? -1
    }
    
    func getGroupFreeListTitles() -> [Int : String] {
        let x = source?.getGroupFreeListTitles()
        if x == nil
        {
            print("PopulateMenuInteractor >> In getGroupFreeListTitles >> Error: Failed to Retrieve Count")
        }
        return x ?? [:]
    }
    
    func getGroupCount() -> Int {
        let x = source?.getGroupCount()
        if x == -1
        {
            print("PopulateMenuInteractor >> In getGroupCount >> Error: Failed to Retrieve Count")
        }
        return x ?? -1
    }
    
    func getGroupTitles(groupKey: Int) -> [Int : String] {
        return (source?.getPermanentListTitles())!
    }
    
    func getGroupListCount(groupKey: Int) -> Int {
        print("PopulateMenuInteractor >> In getGroupListCount")
        return -1
    }
    
    func getGroupListTitles(groupKey: Int) -> [Int : String] {
        print("PopulateMenuInteractor >> In getGroupListTitles")
        return [:]
    }
    func getListTitle(listKey: Int) -> String {
        print("PopulateMenuInteractor >> In getListTitle")
        return ""
    }
    
    func getGroups() -> [Group]? {
        let x = source?.getGroups()
        if x == nil
        {
            print("PopulateMenuInteractor >> In getPermanentListTitles >> Error: Failed to Retrieve Count")
        }
        return x ?? nil
    }
    
    //MARK: CRUD - UPDATE
    func renameList(listKey: Int, newName: String) -> Bool {
        print("PopulateMenuInteractor >> In renameList")
        return false
    }
    
    func renameGroup(groupKey: Int, newName: String) -> Bool {
        //Check if group with newName exists
        var x = source?.groupExists(groupName: newName)
        if x == nil || x == true
        {
            return false
        }
        
        //Rename the Group with groupKey
        x = source?.changeGroupName(groupKey: groupKey, newGroupName: newName)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    func ungroup(groupKey: Int) -> Bool {
        let x = source?.ungroup(groupKey: groupKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    //MARK: CRUD - DELETE
    func deleteGroup(groupKey: Int) -> Bool {
        let x = source?.removeGroup(groupKey: groupKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    func deleteList(listKey: Int) -> Bool {
        let x = source?.deleteList(listKey: listKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
    
    func removeListFromGroup(listKey: Int, groupKey: Int) -> Bool {
        let x = source?.removeListFromGroup(listKey: listKey, groupKey: groupKey)
        if x == nil || x == false
        {
            return false
        }
        return true
    }
}
