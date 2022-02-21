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
  @IBOutlet weak var headerView: UIView!
  
  private var wallpaperCollection: UICollectionView?
  
  var isKeyboardVisible:Bool = false
  var titleEnabled = false
  var currentTitle: String = ""
  var wallpapers:[String]?
  var keyboardHeight: CGFloat?
  
  //END OF DATA MEMBERS
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //Misc Attribute Setup
    
    let key = presenter?.getListKey()
    setupUI(key ?? Constants.newListKey)
    if key ?? Constants.newListKey >= Constants.staticListCount
    {
      wallpapers = presenter?.getWallpapers()
    }
        
    if key == 0
    {
      setupWeatherBackground()
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    dismissKeyboard()
  }
  
  func setPresenter(_ presenter: (ProtocolInteractorToPresenterPopulateList & ProtocolViewToPresenterPopulateList)?)
  {
    self.presenter = presenter
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    let views = self.navigationController?.viewControllers
    presenter?.updateCount(views ?? [])
  }
  
  func resetTitle(_ newTitle: String) {
    DispatchQueue.main.async {
      //Update UI on main thread
      self.listTitle.text = newTitle
    }
  }
  
  func createNewItem(_ sender: UIButton) {
    
    //TO GENERATE AN ALERT
    
    let alert = UIAlertController(title: Constants.UIDefaults.NewListItem.titleMessage, message: "", preferredStyle: .alert)
    alert.addTextField()
    let textfield = alert.textFields?[0]
    textfield?.placeholder = Constants.UIDefaults.NewListItem.newText
    
    let doneButton = UIAlertAction(title: Constants.UIDefaults.NewListItem.rightButtonText, style: .default)
    { (action) in
      
      //Get the textfield for the alert
      let newText = textfield?.text
      
      //Check if Text Field is Empty
      if newText?.isEmpty == true
      {
        //POP AN ERROR HERE
        Utilities.popAnError(self, 2)
      }
      else
      {
        //Change the backend
        self.presenter?.addNewTask(text: newText ?? Constants.emptyString)
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
  func getFrame() -> CGRect {
    return view.frame
  }
  
}

//Utilities Related Functionality
extension PopulateList
{
  private func setupUI(_ key: Int)
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
    
    //Set CollectionView
    if key >= Constants.staticListCount
    {
      setCollection()
    }
    
    //Setting Notifications for Keyboard
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardDidShow),
      name: UIResponder.keyboardDidShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
    
    //List Title Action
    listTitle.addTarget(self, action: #selector(titleTapped), for: .editingDidBegin)
    
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
        titleEnabled = true
      }
      else
      {
        listTitle.resignFirstResponder()
      }
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    dismissKeyboard()
    
    if textField == listTitle
    {
      hideBackgroundBar()
      
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
      else if presenter?.changeListTitle(newTitle: listTitle.text ?? Constants.emptyString) == true
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
      textField.text = Constants.emptyString
      textField.placeholder = Constants.UIDefaults.NewListItem.placeholderText
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
    listItems.addGestureRecognizer(tap)
  }
  
  func setCollection()
  {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    wallpaperCollection = UICollectionView(frame: newItem.frame, collectionViewLayout: layout)
    wallpaperCollection?.showsHorizontalScrollIndicator = false
    
    wallpaperCollection?.isHidden = true
      
    wallpaperCollection?.layer.borderWidth = 5.0
    wallpaperCollection?.layer.borderColor = UIColor.secondarySystemFill.cgColor
    
    wallpaperCollection?.register(WallpaperCollectionCell.nib(), forCellWithReuseIdentifier: Constants.UIDefaults.WallpaperCell.identifier)
    wallpaperCollection?.delegate = self
    wallpaperCollection?.dataSource = self
    
    wallpaperCollection?.isUserInteractionEnabled = true
  }
  
  func showBackgroundBar()
  {
    newItem.isHidden = true
    wallpaperCollection?.isHidden = false
    wallpaperCollection?.frame = CGRect(x: 0, y: view.frame.maxY - (keyboardHeight ?? 0) - 80, width: view.frame.width, height: 80)
    view.addSubview(wallpaperCollection ?? UICollectionView())
  }
  
  func hideBackgroundBar()
  {
    wallpaperCollection?.removeFromSuperview()
    newItem.isHidden = false
    titleEnabled = false
  }
  
  func colorScreen(_ color: UIColor){
    DispatchQueue.main.async { [self] in
      //Update UI on main thread
      view.backgroundColor = color
    }
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
      self.presenter?.pushToEditText(itemKey: key, newText: newText ?? Constants.emptyString)
      
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
      self.keyboardHeight = keyboardRectangle.height
      
      if isKeyboardVisible == false
      {
        UIView.animate(withDuration: 0.50) { [self] in
          self.newItemBottomContraint.constant = keyboardHeight ?? CGFloat()
        }
        isKeyboardVisible = true
      }
      else if newItemBottomContraint.constant > 0
      {
        newItemBottomContraint.constant = 0
        newItemBottomContraint.constant = keyboardHeight ?? CGFloat()
      }
      
      if titleEnabled
      {
        showBackgroundBar()
      }
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    UIView.animate(withDuration: 0.50) {
      self.newItemBottomContraint.constant = 0
    }
    isKeyboardVisible = false
    
    if titleEnabled
    {
      titleEnabled = false
      hideBackgroundBar()
    }
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
  
  @objc func titleTapped()
  {
    titleEnabled = true
  }
  @objc func keyboardDidShow(_ notification: Notification) {
    hideKeyboardWhenTappedAround()
  }
}

//MARK: Collection View Related Functions
extension PopulateList: UICollectionViewDelegate, UICollectionViewDataSource
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return wallpapers?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UIDefaults.WallpaperCell.identifier, for: indexPath) as! WallpaperCollectionCell
    let color = UIColor(named: wallpapers?[indexPath.row] ?? "Col_Default") ?? UIColor.systemBackground
    cell.setupCell(color: color, colorName: wallpapers?[indexPath.row] ?? "Col_Default")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! WallpaperCollectionCell

    let color = cell.getColor()
    let colorName = cell.getColorName()
    colorScreen(color)
    presenter?.setColor(colorName)
  }
}

//MARK: Weather Related Functionalities
extension PopulateList
{
  func setupWeatherBackground()
  {
    //Test this color scheme out
    newItem.backgroundColor = .secondarySystemBackground
    
    guard let backgroundVideo = presenter?.getBackgroundView() else {
      return
    }
    
    view.addSubview(backgroundVideo)
    view.sendSubviewToBack(backgroundVideo)
  }
}
