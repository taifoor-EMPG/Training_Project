//
//  Populate List.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateList: UIViewController, Proto_PTOV_PopulateList, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    //DATA MEMBERS
    
    var presenter: (Proto_ITOP_PopulateList & Proto_VTOP_PopulateList)?
    @IBOutlet weak var listItems: UITableView!
    @IBOutlet weak var listTitle: UITextField!
    var currentTitle: String = ""
    //END OF DATA MEMBERS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Misc Attribute Setup
        setupUI()
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
        currentTitle = (presenter?.getListName())!
        listTitle.text = currentTitle
        listTitle.delegate = self
        
        var result = presenter?.allowEditing(currentTitle)
        if result == nil || result == false
        {
            listTitle.isUserInteractionEnabled = false
        }
        else
        {
            listTitle.isUserInteractionEnabled = true
        }
        
        result = presenter?.isFirstOpen()
        
        if result == true
        {
            listTitle.becomeFirstResponder()
        }
        else
        {
            listTitle.resignFirstResponder()
        }
        
        //Set Date for My Day
        /*if listTitle.text == Constants.listsTitleArray[0]
        {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
            listTitle.text = listTitle.text! + "\n" + result
        }*/
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
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
        else if presenter?.changeListTitle(oldTitle: currentTitle, newTitle: listTitle.text!) == true
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
}


//Table Related Functions
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
        tableView.cellForRow(at: indexPath)
        presenter?.pushToEditText(itemNumber: indexPath.row)
    }
}
