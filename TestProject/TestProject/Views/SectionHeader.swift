//
//  SectionHeader.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 02/02/2022.
//

import UIKit

protocol SectionHeaderProtocols: AnyObject
{
    func didPressOptions()
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
    private var rowsInSection = -1
    
    private weak var delegate: SectionHeaderProtocols?
    
    //END MEMBERS
    
    
    @IBAction func optionsPressed(_ sender: UIButton)
    {
        //Pop Up New Menu Here
        print("SECTION HEADER OPTIONS PRESSED")
        delegate?.didPressOptions()
    }
    
    @IBAction func collapserPressed(_ sender: UIButton)
    {
        if self.collapsed == true
        {
            //Is collapsed - uncollapse it
            collapser.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            self.collapsed = false
            delegate?.didPressCollapser(section: sectionID, isCollapsing: collapsed)
        }
        else
        {
            //Is not collapsed - collapse it
            collapser.setImage(UIImage(systemName: "chevron.right"), for: .normal)
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
