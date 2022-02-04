//
//  GroupOptions.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 03/02/2022.
//

import UIKit

protocol GroupOptionsProtocols
{
    func addDeleteLists()
    func renameGroup(groupKey: Int, groupName: String) -> Bool
    func deleteUngroup()
}


class GroupOptions: UIViewController
{
 
    //DATA MEMBERS
    
    private var isGroupEmpty: Bool?
    private var groupName: String?
    private var groupKey: Int?
    
    private var delegate: GroupOptionsProtocols?
    
    ///View Controller Outlets
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var upperBar: UIView!
    @IBOutlet weak var deleteUngroup: UIButton!
    //END OF DATA MEMBERS
    
    
    //Setup Functionalities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionView.layer.cornerRadius = 10
        upperBar.layer.cornerRadius = 3
        if isGroupEmpty == true
        {
            //DELETE GROUP
            deleteUngroup.setTitle(Constants.UIDefaults.groupOptions.deleteTitle, for: .normal)
            deleteUngroup.setImage(UIImage(systemName: Constants.UIDefaults.groupOptions.deleteImage), for: .normal)
        }
        else
        {
            //UNGROUP
            deleteUngroup.setTitle(Constants.UIDefaults.groupOptions.ungroupTitle, for: .normal)
            deleteUngroup.setImage(UIImage(systemName: Constants.UIDefaults.groupOptions.ungroupImage), for: .normal)
        }
    }
    
    func groupStatus(isEmpty: Bool, groupKey: Int, groupName: String, reference: GroupOptionsProtocols?)
    {
        isGroupEmpty = isEmpty
        self.groupKey = groupKey
        self.groupName = groupName
        delegate = reference
    }

    //MARK: IBACTION FUNCTIONALITIES
    
    @IBAction func addRemoveLists(_ sender: UIButton)
    {
        
    }
    
    @IBAction func renameGroup(_ sender: UIButton)
    {
        let alert = UIAlertController(title: Constants.UIDefaults.newGroup.title, message: "", preferredStyle: .alert)
        alert.addTextField()
        let textfield = alert.textFields![0]
        //Set Old Group Name Here
        textfield.text = groupName
        let renameButton = UIAlertAction(title: Constants.UIDefaults.groupOptions.renameTitle, style: .default)
        { (action) in
            
            //Get New Group Name
            let newGroupName = textfield.text
            let x = self.delegate?.renameGroup(groupKey: self.groupKey!, groupName: newGroupName!)
            
            if x == false
            {
                Utilities.popAnError(self as UIViewController, 6)
            }
            
        }
        
        let cancelButton = UIAlertAction(title: Constants.UIDefaults.newGroup.leftButtonText, style: .default)
        { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(renameButton)
        alert.becomeFirstResponder()
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteUngroup(_ sender: UIButton)
    {
        
    }
}
