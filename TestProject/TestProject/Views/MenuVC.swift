//
//  MenuVC.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

class MenuVC: UIViewController
{
  //MARK: DATA MEMBERS
  
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
  
  func setPresenter(_ presenter: (ProtocolViewToPresenterPopulateMenu & ProtocolInteractorToPresenterPopulateMenu)?){
    self.presenter = presenter
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    //Loads Up Data for Presenter
    presenter?.viewDidLoad()
  }
  
  @IBAction func listTapped(_ sender: UIButton) {
    let title = (sender.titleLabel?.text) ?? Constants.emptyString
    
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
    let alert = UIAlertController(title: Constants.UIDefaults.NewGroup.title, message: "", preferredStyle: .alert)
    alert.addTextField()
    let textfield = alert.textFields?[0]
    textfield?.text = Constants.UIDefaults.NewGroup.newGroupTitle
    
    let createButton = UIAlertAction(title: Constants.UIDefaults.NewGroup.rightButtonText, style: .default)
    { (action) in
      
      //Get the textfield for the alert
      let newGroupName = textfield?.text
      self.presenter?.createNewGroup(groupName: newGroupName ?? Constants.emptyString)
      let key = self.presenter?.getNewGroupKey()
      
      //refetch data
      self.optionalLists.reloadData()
      
      //Next Prompt alert
      self.presenter?.newGroupPrompt(groupKey: key ?? Constants.newGroupKey)
    }
    
    let cancelButton = UIAlertAction(title: Constants.UIDefaults.NewGroup.leftButtonText, style: .default)
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
    presenter?.setStaticListTitles()
    
    guard titles != nil else
    {
      LoggingSystemFlow.printLog("Menu VC >> setupUI >> Error: Presenter Failed to Get Data ")
      return
    }
    
    var keys = Array(titles?.keys ?? [:].keys)
    keys.sort()
    
    listMyDay.setTitle(titles?[keys[0]], for: .normal)
    listImportant.setTitle(titles?[keys[1]], for: .normal)
    listPlanned.setTitle(titles?[keys[2]], for: .normal)
    listAssigned.setTitle(titles?[keys[3]], for: .normal)
    listTasks.setTitle(titles?[keys[4]], for: .normal)
    
    //Set Count For Each List Here
    for i in 0...(Constants.staticListCount - 1)
    {
      presenter?.setActiveListCount(listKey: keys[i])
    }

    //Set Table Attributes
    optionalLists.delegate = self
    optionalLists.dataSource = self
    
    //Set Navigation Bar Title
    navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.UIDefaults.navBarReturnTitle, style: .plain, target: nil, action: nil)
  }
  
  func setCount(listKey: Int, count: Int)
  {
    switch listKey
    {
    case 0:
          myDayCount.text = Utilities.convertToString(count)
    case 1:
          importantCount.text = Utilities.convertToString(count)
    case 2:
          plannedCount.text = Utilities.convertToString(count)
    case 3:
          assignedCount.text = Utilities.convertToString(count)
    case 4:
          tasksCount.text = Utilities.convertToString(count)
    default:
      return
    }
  }
  
  func setStaticListTitles()
  {
    titles = presenter?.getStaticListTitles()
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
    return presenter?.numberOfSections() ?? 0
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
    presenter?.pushToOpenList(listKey: cell.getListKey(), listName: cell.listTitle.text ?? Constants.newListTitle)
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
