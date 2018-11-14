//
//  SingleGroupCell.swift
//  Attendance
//
//  Created by Tijs Fertinel on 14/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class SingleGroupCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    
    @IBAction func removeGroupPressed(_ sender: Any) {
        delegate?.groupRemovePressed(sender: self)
    }
    
    var delegate: SingleGroupCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

@objc protocol SingleGroupCellDelegate: class {
    func groupRemovePressed(sender: SingleGroupCell)
}
