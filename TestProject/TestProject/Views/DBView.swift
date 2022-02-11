//
//  Test.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 07/02/2022.
//

import UIKit
import CoreData

class DBView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var groupCounter: UILabel!
    @IBOutlet weak var listCounter: UILabel!
    @IBOutlet weak var itemCounter: UILabel!
    
    @IBOutlet weak var groupTable: UITableView!
    
    private var groups:[Group]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        setCounters()
        groupTable.delegate = self
        groupTable.dataSource = self
    }
    
    func setCounters()
    {
        do
        {
            let request = Counters.fetchRequest() as NSFetchRequest<Counters>
            let counter = try context!.fetch(request)
            
            groupCounter.text = String(counter[0].group)
            listCounter.text = String(counter[0].list)
            itemCounter.text = String(counter[0].listItem)
        }
        catch
        {
          //Error Failed to Fetch Data
          LoggingSystemFlow.printLog("ERROR: In Test >> func setCounters >> Failed to Fetch")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do
        {
            let request = Group.fetchRequest() as NSFetchRequest<Group>
            let groups = try context!.fetch(request)
            self.groups = groups
            return groups.count
        }
        catch
        {
          //Error Failed to Fetch Data
          LoggingSystemFlow.printLog("ERROR: In Test >> func setCounters >> Failed to Fetch")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var string = groups?[indexPath.row].name
        
        groups?[indexPath.row].setListsArray()
    
        for i in groups![indexPath.row].listsArray
        {
            string! += " - " + i.name!
        }
        cell.textLabel?.text = string
        return cell
    }
}
