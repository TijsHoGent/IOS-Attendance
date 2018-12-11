//
//  LezingTableViewCell.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class LezingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func publishLezing(_ sender: Any) {
        delegate?.buttonPressed(sender: self)
    }
    
    var event: Lezing?
    var delegate: LezingTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

@objc protocol LezingTableViewCellDelegate: class {
    @objc func buttonPressed(sender: LezingTableViewCell)
    
    
}
