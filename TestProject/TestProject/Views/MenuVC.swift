//
//  MenuVC.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

class MenuVC: UIViewController
{
    //DATA MEMBERS
   
    var presenter: (Proto_VTOP_PopulateMenu & Proto_ITOP_PopulateMenu)?         //Belong to extension MenuVC: Proto_PTOV_PopulateMenu
    
    //View Controller Outlets
    @IBOutlet weak var optionalLists: UITableView!
    
    @IBOutlet weak var listMyDay: UIButton!
    @IBOutlet weak var listImportant: UIButton!
    @IBOutlet weak var listPlanned: UIButton!
    @IBOutlet weak var listAssigned: UIButton!
    @IBOutlet weak var listTasks: UIButton!
    
    @IBOutlet weak var myDayCount: UILabel!
    @IBOutlet weak var importantCount: UILabel!
    @IBOutlet weak var plannedCount: UILabel!
    @IBOutlet weak var assignedCount: UILabel!
    @IBOutlet weak var tasksCount: UILabel!
    
    //END DATA MEMEBRS

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //Ask the Presenter to Perform viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func listTapped(_ sender: UIButton) {
        presenter?.pushToOpenList(listName: (sender.titleLabel?.text)!)
    }
    
    @IBAction func createNewList(_ sender: UITableViewCell) {
        presenter?.pushToAddNewList()
    }
    
    @IBAction func loadProfile(_ sender: UIButton) {
        presenter?.pushToProfile()
    }
    
    @IBAction func performSearch(_ sender: UIButton) {
        presenter?.pushToSearch()
    }
}



//Utility Functions that are Private
extension MenuVC
{
    private func setupUI()
    {
        //Set Label for Each List Here
        listMyDay.titleLabel?.text = Constants.listsTitleArray[0]
        listImportant.titleLabel?.text = Constants.listsTitleArray[1]
        listPlanned.titleLabel?.text = Constants.listsTitleArray[2]
        listAssigned.titleLabel?.text = Constants.listsTitleArray[3]
        listTasks.titleLabel?.text = Constants.listsTitleArray[4]
        
        //Set Count For Each List Here
        myDayCount.text = presenter?.getListSize(listName: Constants.listsTitleArray[0]) ?? ""
        importantCount.text = presenter?.getListSize(listName: Constants.listsTitleArray[1]) ?? ""
        plannedCount.text = presenter?.getListSize(listName: Constants.listsTitleArray[2]) ?? ""
        assignedCount.text = presenter?.getListSize(listName: Constants.listsTitleArray[3]) ?? ""
        tasksCount.text = presenter?.getListSize(listName: Constants.listsTitleArray[4]) ?? ""
        
        //Set Table Attributes
        //optionalLists.register(OptionalListCell.self, forCellReuseIdentifier: Constants.UIDefaults.labels.optionalListCell)
        optionalLists.delegate = self
        optionalLists.dataSource = self
        
        //Set Navigation Bar Title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.navBarReturnTitle, style: .plain, target: nil, action: nil)
    }
}



//For View to Communicate User Responses to Presenter
extension MenuVC: Proto_PTOV_PopulateMenu
{
    
}



//For View to conform to Table View
extension MenuVC: UITableViewDelegate, UITableViewDataSource
{
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.setCell(tableView: tableView, forRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionalListCell
        presenter?.pushToOpenList(listName: cell.listTitle.text!)
    }
}
