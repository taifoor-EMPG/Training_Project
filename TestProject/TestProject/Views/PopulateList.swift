//
//  Populate List.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateList: UIViewController, ProtocolPresenterToViewPopulateList, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
  //MARK: DATA MEMBERS
  
  private var presenter: (ProtocolInteractorToPresenterPopulateList & ProtocolViewToPresenterPopulateList)?
  @IBOutlet weak var listItems: UITableView!
  @IBOutlet weak var listTitle: UITextField!
  @IBOutlet weak var newItem: UITextField!
  @IBOutlet weak var newItemBottomContraint: NSLayoutConstraint!
  
  var isKeyboardVisible: Bool?
  var currentTitle: String = ""
  //END OF DATA MEMBERS
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //Misc Attribute Setup
    setupUI()
  }
  
  func setPresenter(_ presenter: (ProtocolInteractorToPresenterPopulateList & ProtocolViewToPresenterPopulateList)?)
  {
    self.presenter = presenter
  }
  
  func setRestTitle(_ newTitle: String) {
    DispatchQueue.main.async {
      //Update UI on main thread
      self.listTitle.text = newTitle
    }
  }
  
  func createNewItem(_ sender: UIButton) {
    
    //TO GENERATE AN ALERT
    
    let alert = UIAlertController(title: Constants.UIDefaults.NewListItem.titleMessage, message: "", preferredStyle: .alert)
    alert.addTextField()
    let textfield = alert.textFields![0]
    textfield.placeholder = Constants.UIDefaults.NewListItem.newText
    
    let doneButton = UIAlertAction(title: Constants.UIDefaults.NewListItem.rightButtonText, style: .default)
    { (action) in
      
      //Get the textfield for the alert
      let newText = textfield.text
      
      //Check if Text Field is Empty
      if newText?.isEmpty == true
      {
        //POP AN ERROR HERE
        Utilities.popAnError(self, 2)
      }
      else
      {
        //Change the backend
        self.presenter?.addNewTask(text: newText!)
        self.listItems.reloadData()
      }
    }
    
    let cancelButton = UIAlertAction(title: Constants.UIDefaults.EditListItem.leftButtonText, style: .default)
    { (action) in
      
      alert.dismiss(animated: true, completion: nil)
    }
    
    alert.addAction(cancelButton)
    alert.addAction(doneButton)
    self.present(alert, animated: true, completion: nil)
    //END OF ALERT
  }
  
}

//Utilities Related Functionality
extension PopulateList
{
  private func setupUI()
  {
    //Set Table Attributes
    listItems.delegate = self
    listItems.dataSource = self
    
    //Set Text Field Delegate
    newItem.delegate = self
    
    //Setting Up UI Components
    currentTitle = (presenter?.getListName()) ?? Constants.newListTitle
    listTitle.text = currentTitle
    listTitle.delegate = self
    
    
    let result = presenter?.allowEditing()
    if result == nil || result == false
    {
      listTitle.isUserInteractionEnabled = false
    }
    else
    {
      listTitle.isUserInteractionEnabled = true
    }
    
    if result == true
    {
      let editing = presenter?.isFirstOpen()
      
      if editing == true
      {
        listTitle.becomeFirstResponder()
        isKeyboardVisible = true
      }
      else
      {
        listTitle.resignFirstResponder()
        isKeyboardVisible = false
      }
    }
    else
    {
      isKeyboardVisible = false
    }
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
    hideKeyboardWhenTappedAround()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    dismissKeyboard()
    
    if textField == listTitle
    {
      //String is Empty
      if listTitle.text?.isEmpty == true
      {
        //Pop Error
        Utilities.popAnError(self, 2)
        return false
      }
      
      if listTitle.text == currentTitle
      {
        //No Change in Text
        listTitle.resignFirstResponder()
        return true
      }
      else if presenter?.changeListTitle(newTitle: listTitle.text!) == true
      {
        //New List Name Approved by DB
        currentTitle = listTitle.text!
        listTitle.resignFirstResponder()
        return true
      }
      
      //Database did not allow a change
      //Pop Error
      Utilities.popAnError(self, 1)
      return false
    }
    else if textField == newItem
    {
      let text = textField.text ?? ""
      if text.isEmpty == false
      {
        presenter?.addNewTask(text: text)
        listItems.reloadData()
      }
    }
    return false
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
}


//MARK: Table Related Functions
extension PopulateList
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfRowsInSection() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return presenter?.setCell(tableView: tableView, forRowAt: indexPath) ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
    
    //TO GENERATE AN ALERT
    
    let alert = UIAlertController(title: Constants.UIDefaults.EditListItem.titleMessage, message: "", preferredStyle: .alert)
    alert.addTextField()
    let textfield = alert.textFields![0]
    textfield.text = cell.getText()
    let key = cell.getItemKey()
    
    let renameButton = UIAlertAction(title: Constants.UIDefaults.EditListItem.rightButtonText, style: .default)
    { (action) in
      
      //Get the textfield for the alert
      let newText = textfield.text
      
      //Change the backend
      self.presenter?.pushToEditText(itemKey: key, newText: newText!)
      
      self.listItems.reloadData()
    }
    
    let cancelButton = UIAlertAction(title: Constants.UIDefaults.EditListItem.leftButtonText, style: .default)
    { (action) in
      
      alert.dismiss(animated: true, completion: nil)
    }
    
    alert.addAction(cancelButton)
    alert.addAction(renameButton)
    self.present(alert, animated: true, completion: nil)
    
    //END OF ALERT
  }
  
  //Set an editing style when interacted
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  //Delete swiped row
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    presenter?.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
    listItems.reloadData()
  }
}

//MARK: Object-C Functions
extension PopulateList
{
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      
      if isKeyboardVisible == false
      {
        UIView.animate(withDuration: 0.50) {
          self.newItemBottomContraint.constant = keyboardHeight
        }
        isKeyboardVisible = true
      }
      else if newItemBottomContraint.constant > 0
      {
        newItemBottomContraint.constant = 0
        newItemBottomContraint.constant = keyboardHeight
      }
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    UIView.animate(withDuration: 0.50) {
      self.newItemBottomContraint.constant = 0
    }
    isKeyboardVisible = false
  }
  
  @objc func dismissKeyboard() {
    if isKeyboardVisible == true
    {
      UIView.animate(withDuration: 0.50) {
        self.newItemBottomContraint.constant = 0
      }
      isKeyboardVisible = false
    }
    view.endEditing(true)
  }
}
