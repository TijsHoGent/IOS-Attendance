//
//  GroupTableViewCell.swift
//  Attendance
//
//  Created by Tijs Fertinel on 31/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

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

extension GroupTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
    
            cell.textLabel?.text = groups[indexPath.row].groupName
        
        return cell
    }
}
