//
//  Populate List.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 21/01/2022.
//

import UIKit

class PopulateList: UIViewController, Proto_PTOV_PopulateList, UITableViewDelegate, UITableViewDataSource
{
    //DATA MEMBERS
    
    var presenter: (Proto_ITOP_PopulateList & Proto_VTOP_PopulateList)?
    @IBOutlet weak var listItems: UITableView!
    
    //END OF DATA MEMBERS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Misc Attribute Setup
        
        setupUI()
    }
}

extension PopulateList
{
    private func setupUI()
    {
        //Set Table Attributes
        //listItems.register(OptionalListCell.self, forCellReuseIdentifier: Constants.UIDefaults.labels.optionalListCell)
        listItems.delegate = self
        listItems.dataSource = self
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
        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        presenter?.pushToEditText(itemNumber: indexPath.row)
    }
}
