//
//  GroupPrompt.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 02/02/2022.
//

import UIKit

protocol GroupPromptProtocol: AnyObject
{
    func setRows(groupKey: Int) -> Int
    func setCell(_ cell: Listing, indexPath: IndexPath, rowCount: Int, groupKey: Int)
}


class GroupPrompt: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //DATA MEMBERS
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    private weak var delegate: GroupPromptProtocol?
    
    private var groupKey: Int?
    private var rowCount: Int?
    
    //END DATA MEMEBERS
    
    override func viewDidLoad() {
        subView.layer.cornerRadius = 10
        listTable.delegate = self
        listTable.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    func setDelegate(_ reference: GroupPromptProtocol?)
    {
        delegate = reference
    }
    
    func setGroupKey(groupKey: Int)
    {
        self.groupKey = groupKey
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowCount = delegate?.setRows(groupKey: groupKey ?? -1)
        return rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.labels.listing, for: indexPath) as? Listing {
          delegate?.setCell(cell, indexPath: indexPath, rowCount: rowCount ?? 0, groupKey: groupKey ?? Constants.emptyString)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
