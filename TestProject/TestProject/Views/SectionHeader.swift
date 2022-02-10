//
//  SectionHeader.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 02/02/2022.
//

import UIKit

protocol SectionHeaderProtocols: AnyObject
{
    func didPressOptions(section: Int, groupKey: Int, groupName: String)
    func didPressCollapser(section: Int, isCollapsing: Bool)
}


class SectionHeader: UITableViewCell
{
    //DATA MEMBERS
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var collapser: UIButton!
    
    private var sectionID: Int = -1
    private var groupKey: Int = -1
    private var collapsed: Bool = false
    
    private weak var delegate: SectionHeaderProtocols?
    
    //END MEMBERS
    
    
    @IBAction func optionsPressed(_ sender: UIButton)
    {
      delegate?.didPressOptions(section: sectionID, groupKey: groupKey, groupName: groupTitle.text ?? Constants.emptyString)
    }
    
    @IBAction func collapserPressed(_ sender: UIButton)
    {
        if self.collapsed == true
        {
            //Is collapsed - uncollapse it
            collapser.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            optionsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            optionsButton.isEnabled = true
            self.collapsed = false
            delegate?.didPressCollapser(section: sectionID, isCollapsing: collapsed)
        }
        else
        {
            //Is not collapsed - collapse it
            collapser.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            optionsButton.setImage(UIImage(), for: .normal)
            optionsButton.isEnabled = false
            self.collapsed = true
            delegate?.didPressCollapser(section: sectionID, isCollapsing: collapsed)
        }
    }
    
    func setupCell(groupKey:Int, groupName: String, section: Int, reference: SectionHeaderProtocols?)
    {
        self.delegate = reference
        self.groupKey = groupKey
        groupTitle.text = groupName
        self.sectionID = section
    }
    
}
