//
//  ListItemCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

protocol ListItemCellProtocols
{
    func didTapChecked(itemKey: Int, newStatus: Bool)
}

class ListItemCell: UITableViewCell {

    //DATA MEMBERS
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkMark: UIButton!
    
    private var status:Bool?
    private var itemKey:Int?
    
    private var delegate: ListItemCellProtocols?
    //END OF DATA MEMBERS
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getText() -> String
    {
        return label.text!
    }
    
    func getItemKey() -> Int
    {
        return itemKey!
    }
    
    @IBAction func tappedCheck(_ sender: UIButton) {
        
        let attrRedStrikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]

        let attrBlueNoStrikethroughStyle = [NSAttributedString.Key.foregroundColor:  UIColor.label,]

        if status == false
        {
            status = true
            delegate?.didTapChecked(itemKey: itemKey!, newStatus: status!)
            DispatchQueue.main.async { [self] in
                //Update UI on main thread
                checkMark.setImage(UIImage(named: Constants.UIDefaults.images.checkedCircle), for: .normal)
                //Strike Through Text
                let text = NSAttributedString(string: label.text!, attributes: attrRedStrikethroughStyle)
                label.attributedText = text
            }
            
        }
        else
        {
            status = false
            delegate?.didTapChecked(itemKey: itemKey!, newStatus: status!)
            DispatchQueue.main.async { [self] in
                //Update UI on main thread
                checkMark.setImage(UIImage(named: Constants.UIDefaults.images.uncheckedCircle), for: .normal)
                //Unstrike through text
                let text = NSAttributedString(string: label.text!, attributes: attrBlueNoStrikethroughStyle)
                label.attributedText = text
            }
            
        }
    }
    
    func setupCell(itemKey: Int, text: String, status: Bool, reference: ListItemCellProtocols?)
    {
        self.delegate = reference
        
        self.itemKey = itemKey
        let attrRedStrikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]
        
        label.text = text
        self.status = status
        if status == true
        {
            checkMark.setImage(UIImage(named: Constants.UIDefaults.images.checkedCircle), for: .normal)
            let temp = NSAttributedString(string: label.text!, attributes: attrRedStrikethroughStyle)
            label.attributedText = temp
        }
        else
        {
            checkMark.setImage(UIImage(named: Constants.UIDefaults.images.uncheckedCircle), for: .normal)
        }
    }
  
}
