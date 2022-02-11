//
//  Search.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class Search: UIViewController, ProtocolPresenterToViewSearch, UITextFieldDelegate
{
  //DATA MEMBERS
  
  private var presenter: (ProtocolViewToPresenterSearch & ProtocolInteractorToPresenterSearch)?
  
  ///View Controller Outlets
  @IBOutlet weak var searchBox: UITextField!
  @IBOutlet weak var bar: UIStackView!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var searchResults: UITableView!
  //END OF DATA MEMBERS
  
  
  func setPresenter(_ presenter: (ProtocolViewToPresenterSearch & ProtocolInteractorToPresenterSearch)?)
  {
    self.presenter = presenter
  }
  
  override func viewDidLoad() {
    self.view.bringSubviewToFront(bar)
    
    image.isHidden = false
    searchResults.isHidden = true
    
    searchBox.delegate = self
    searchBox.addTarget(self, action: #selector(textFieldWasTapped), for: .editingChanged)
    
    searchResults.delegate = self
    searchResults.dataSource = self
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @IBAction func cancelTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchBox.resignFirstResponder()
    presenter?.fetchData(query: searchBox.text ?? Constants.emptyString)
    searchResults.reloadData()
    return true
  }
}

//MARK: Objective-C Functions
extension Search
{
  @objc func textFieldWasTapped(textField: UITextField) {
    image.isHidden = true
    searchResults.isHidden = false
  }
  
  //Dismisses Keyboard if tapped anywhere on the screen
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

//MARK: Table Related Functionalities
extension Search: UITableViewDelegate, UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView.isHidden == true
    {
      return 0
    }
    //Fetch Row Count
    let rowCount = presenter?.getRowCount() ?? 0
    
    if rowCount == 0
    {
      image.image = UIImage(systemName: "plus")
      searchResults.isHidden = true
      image.isHidden = false
    }
    
    return rowCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.Labels.searchResultCell) as? ResultCell
    {
      return presenter?.setupCell(cell: cell, index: indexPath.row) ?? UITableViewCell()
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.Labels.searchResultCell) as? ResultCell
    {
      let key = cell.getKey()
      presenter?.pushToOpenList(listKey: key)
    }
    return
  }
  
}
