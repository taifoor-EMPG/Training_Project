//
//  Tester.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 14/02/2022.
//

import UIKit
import CoreData

class Tester: UIViewController
{
  
  //MARK: DATA MEMEBERS
  
  //Counters
  @IBOutlet weak var groupCounter: UILabel!
  @IBOutlet weak var listCounter: UILabel!
  @IBOutlet weak var listItemCounter: UILabel!
  
  //Grouping Table - Tag = 1
  @IBOutlet weak var groupTable: UITableView!
  private var groups: [Group]?
  
  //Listing Table - Tag = 2
  @IBOutlet weak var listTable: UITableView!
  private var lists: [List]?
  
  //List Item Table - Tag = 3
  @IBOutlet weak var listItemTable: UITableView!
  private var listItems: [ListItem]?
  
  struct Constants
  {
    struct CellLabels
    {
      static let groupCell = "TestingGroupCell"
      static let listCell = "TestListCell"
      static let listItemCell = "TestListItemCell"
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    groupTable.dataSource = self
    groupTable.delegate = self
    
    listTable.dataSource = self
    listTable.delegate = self
    
    listItemTable.dataSource = self
    listItemTable.delegate = self
    
    fetchFromCore()
  }
}

//MARK: Table Related Functionalities
extension Tester: UITableViewDelegate, UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView.tag == 1
    {
      return groups?.count ?? 0
    }
    else if tableView.tag == 2
    {
      return lists?.count ?? 0
    }
    else
    {
      return listItems?.count ?? 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView.tag == 1
    {
      if let cell = tableView.dequeueReusableCell(withIdentifier:Tester.Constants.CellLabels.groupCell) as? TestingGroupCell
      {
        let group = groups?[indexPath.row]
        cell.setupCell(key: Int(group?.groupKey ?? -1) , name: group?.name ?? "")
        return cell
      }
    }
    else if tableView.tag == 2
    {
      if let cell = tableView.dequeueReusableCell(withIdentifier: Tester.Constants.CellLabels.listCell) as? TestingListCell
      {
        let list = lists?[indexPath.row]
        cell.setupCell(key: Int(list?.listKey ?? -1), name: list?.name ?? "", isPermanent: list?.isPermanent ?? false, groupName: list?.group?.name ?? "")
        return cell
      }
    }
    else
    {
      if let cell = tableView.dequeueReusableCell(withIdentifier: Tester.Constants.CellLabels.listItemCell) as? TestingListItemCell
      {
        let listItem = listItems?[indexPath.row]
        cell.setupCell(key: Int(listItem?.itemKey ?? -1), text: listItem?.text ?? "", status: listItem?.done ?? false, listName: listItem?.list?.name ?? "")
        return cell
      }
    }
    return UITableViewCell()
  }
  
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
  {
    if tableView.tag == 1
    {
      return "GROUPS"
    }
    else if tableView.tag == 2
    {
      return "LISTS"
    }
    else
    {
      return "LIST ITEMS"
    }
  }
}

//MARK: Misc Private Functions
extension Tester
{
  func fetchFromCore()
  {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    do
    {
      let request = Group.fetchRequest() as NSFetchRequest<Group>
      let groups = try context.fetch(request)
      
      self.groups = groups
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Tester >> fetchFromCore >> func getGroups")
    }
    
    do
    {
      let request = List.fetchRequest() as NSFetchRequest<List>
      let lists = try context.fetch(request)
      
      self.lists = lists
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Tester >> fetchFromCore >> func getLists")
    }
    
    do
    {
      let request = ListItem.fetchRequest() as NSFetchRequest<ListItem>
      let listItems = try context.fetch(request)
      
      self.listItems = listItems
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Tester >> fetchFromCore >> func getListItems")
    }
    
    do
    {
      let request = Counters.fetchRequest() as NSFetchRequest<Counters>
      let counters = try context.fetch(request)
      
      self.groupCounter.text = String(counters[0].group)
      self.listCounter.text = String(counters[0].list)
      self.listItemCounter.text = String(counters[0].listItem)
      
    }
    catch
    {
      //Error Failed to Fetch Data
      LoggingSystemFlow.printLog("ERROR: In Tester >> fetchFromCore >> func getListItems")
    }
    
  }
}
