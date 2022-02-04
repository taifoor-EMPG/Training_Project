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
    func selectedRowAction()
    func setCell(_ cell: Listing)
}


class GroupPrompt: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //DATA MEMBERS
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var listTable: UITableView!
    
    private weak var delegate: GroupPromptProtocol?
    
    private var groupKey: Int?
    //END DATA MEMEBERS
    
    override func viewDidLoad() {
        //subView.layer.cornerRadius = 10
        //subView.layer.cornerCurve = .circular
        listTable.delegate = self
        listTable.dataSource = self
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
        return delegate?.setRows(groupKey: groupKey ?? -1) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIDefaults.labels.listing, for: indexPath) as? Listing {
            delegate?.setCell(cell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell was tapped")
    }
}
