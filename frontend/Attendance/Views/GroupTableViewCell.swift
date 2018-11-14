//
//  GroupTableViewCell.swift
//  Attendance
//
//  Created by Tijs Fertinel on 31/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell, SingleGroupCellDelegate {
    
    func groupRemovePressed(sender: SingleGroupCell) {
        self.groups.removeAll(where: {$0.groupName == sender.groupName.text!})
        self.reload()
        delegate?.groupsUpdated(sender: self)
    }
    
    var delegate: GroupTableViewCellDelegate?

    @IBOutlet weak var groupTableView: UITableView!
    
    var groups: [Group] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupTableView.dataSource = self
        groupTableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reload() {
        groupTableView.reloadData()
    }
}

@objc protocol GroupTableViewCellDelegate : class {
    func groupsUpdated(sender: GroupTableViewCell)
}

extension GroupTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! SingleGroupCell
            cell.delegate = self
            cell.groupName?.text = groups[indexPath.row].groupName
        
        return cell
    }
}
