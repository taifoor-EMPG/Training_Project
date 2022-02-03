//
//  ListItemCell.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 17/01/2022.
//

import UIKit

protocol ListItemCellProtocols
{
    func didTapChecked()
}




class ListItemCell: UITableViewCell {

    //DATA MEMBERS
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkMark: UIButton!
    private var status:Bool = false
    
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
    
    
    @IBAction func tappedCheck(_ sender: UIButton) {
        
        let attrRedStrikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]

        let attrBlueNoStrikethroughStyle = [NSAttributedString.Key.foregroundColor:  UIColor.label,]

        if status == false
        {
            status = true
            checkMark.setImage(UIImage(named: Constants.UIDefaults.images.checkedCircle), for: .normal)
            //Strike Through Text
            let text = NSAttributedString(string: label.text!, attributes: attrRedStrikethroughStyle)
            label.attributedText = text
        }
        else
        {
            status = false
            checkMark.setImage(UIImage(named: Constants.UIDefaults.images.uncheckedCircle), for: .normal)
            //Unstrike through text
            let text = NSAttributedString(string: label.text!, attributes: attrBlueNoStrikethroughStyle)
            label.attributedText = text
        }
    }
    
    
    
    func setupCell(text: String, status: Bool)
    {
        //self.delegate = reference
        
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
