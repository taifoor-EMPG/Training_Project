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
   
    private var presenter: (ProtocolViewToPresenterPopulateMenu & ProtocolInteractorToPresenterPopulateMenu)?
    
    ///View Controller Outlets
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
    
    private var titles: [Int: String]?
    
    private var groupOptionsVC:GroupOptions?
    //END DATA MEMEBRS
    
    func setPresenter(_ presenter: (ProtocolViewToPresenterPopulateMenu & ProtocolInteractorToPresenterPopulateMenu)?)
    {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //Loads Up Data for Presenter
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showActivity()
    }
    
    
    @IBAction func listTapped(_ sender: UIButton) {
        let title = (sender.titleLabel?.text)!
        
        for (key, value) in titles! {
            if value == title
            {
                presenter?.pushToOpenList(listKey: key, listName: value)
                break
            }
        }
    }
    
    
    @IBAction func createNewList(_ sender: UIButton) {
        presenter?.pushToAddNewList()
    }
    
    @IBAction func createNewGroup(_ sender: UIButton)
    {
        let alert = UIAlertController(title: Constants.UIDefaults.newGroup.title, message: "", preferredStyle: .alert)
        alert.addTextField()
        let textfield = alert.textFields![0]
        textfield.text = Constants.UIDefaults.newGroup.newGroupTitle
        
        let createButton = UIAlertAction(title: Constants.UIDefaults.newGroup.rightButtonText, style: .default)
        { (action) in
            
            //Get the textfield for the alert
            let newGroupName = textfield.text
            let key = self.presenter?.createNewGroup(groupName: newGroupName!)
            
            //refetch data
            self.optionalLists.reloadData()
            
            //Next Prompt alert
            self.presenter?.newGroupPrompt(groupKey: key!)
        }
        
        let cancelButton = UIAlertAction(title: Constants.UIDefaults.newGroup.leftButtonText, style: .default)
        { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(createButton)
        self.present(alert, animated: true, completion: nil)
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
        titles = presenter?.getStaticListTitles() ?? nil
        
        guard titles != nil else
        {
            print("Menu VC >> setupUI >> Error: Presenter Failed to Get Data ")
            return
        }
        
        var keys = Array(titles!.keys)
        keys.sort()
        
        listMyDay.setTitle(titles?[keys[0]], for: .normal)
        listImportant.setTitle(titles?[keys[1]], for: .normal)
        listPlanned.setTitle(titles?[keys[2]], for: .normal)
        listAssigned.setTitle(titles?[keys[3]], for: .normal)
        listTasks.setTitle(titles?[keys[4]], for: .normal)
        
        
        //Set Count For Each List Here
        myDayCount.text = Utilities.convertToString(presenter?.getActiveListCount(listKey: keys[0]) ?? 0)
        importantCount.text = Utilities.convertToString(presenter?.getActiveListCount(listKey: keys[1]) ?? 0)
        plannedCount.text = Utilities.convertToString(presenter?.getActiveListCount(listKey: keys[2]) ?? 0)
        assignedCount.text = Utilities.convertToString(presenter?.getActiveListCount(listKey: keys[3]) ?? 0)
        tasksCount.text = Utilities.convertToString(presenter?.getActiveListCount(listKey: keys[4]) ?? 0)
        
        //Set Table Attributes
        optionalLists.delegate = self
        optionalLists.dataSource = self
        
        //Set Navigation Bar Title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.UIDefaults.navBarReturnTitle, style: .plain, target: nil, action: nil)
    }
}



//For View to Communicate User Responses to Presenter
extension MenuVC: ProtocolPresenterToViewPopulateMenu, UIViewControllerTransitioningDelegate
{
    func presentGroupOptions(viewController: GroupOptions) {
        groupOptionsVC = viewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func presentGroupPrompt(viewController: GroupPrompt) {
        groupOptionsVC?.dismiss(animated: true, completion: nil)
        self.present(viewController, animated: true, completion: nil)
    }
    
    func showActivity() {
        DispatchQueue.main.async {
                    //Update UI on main thread
                    self.optionalLists.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showActivity()
    }
    
    func closeSection(indexPath: [IndexPath]) {
        if indexPath.isEmpty == false
        {
            optionalLists.deleteRows(at: indexPath, with: .top)
        }
    }
    
    func openSection(indexPath: [IndexPath]) {
        if indexPath.isEmpty == false
        {
            optionalLists.insertRows(at: indexPath, with: .bottom)
        }
    }
}



//For View to conform to Table View
extension MenuVC: UITableViewDelegate, UITableViewDataSource
{
    //Defines the number of groups that will be there
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 1
    }
    
    //Defines the rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableView(numberOfRowsInSection: section) ?? 0
    }
    
    //Section Header:
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.tableView(titleForHeaderInSection: section)
    }
    
    //Setting up the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    //Alter the Section OutLook
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        presenter?.tableView(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        presenter?.tableView(tableView, heightForHeaderInSection: section) ?? 35.0
    }
    
    //If cell was selected - what to do
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionalListCell
        presenter?.pushToOpenList(listKey: cell.getListKey(), listName: cell.listTitle.text!)
    }
    
    //Set an editing style when interacted
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Delete swiped row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter?.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
        showActivity()
    }
}
