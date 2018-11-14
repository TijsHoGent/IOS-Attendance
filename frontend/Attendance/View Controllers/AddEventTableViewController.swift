//
//  AddEventTableViewController.swift
//  Attendance
//
//  Created by Tijs Fertinel on 30/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class AddEventTableViewController: UITableViewController {

   
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var groupTableViewCell: GroupTableViewCell!
    
    @IBAction func addLocationPressed(_ sender: Any) {
        performSegue(withIdentifier: "searchLocation", sender: sender)
    }
    @IBAction func addGroupsPressed(_ sender: Any) {
        performSegue(withIdentifier: "addGroupsSegue", sender: sender)
    }
    
    @IBAction func unwindToAddEventViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "doneLocationSegue" {
            let sourceController = segue.source as! LocationSearchTableViewController
            
            if let selected = sourceController.selectedLocation {
                self.locationLabel.text = selected.locationName
                self.location = selected
            }
        } else if segue.identifier == "doneGroupSegue"{
            let sourceController = segue.source as! AddGroupsTableViewController
            
            groupTableViewCell.groups = sourceController.selectedGroups
            groupTableViewCell.reload()
        } else {
            return
        }
    }
    
    var lezing: Lezing?
    var location: EventLocation?
    var groups: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selected = lezing {
            navigationItem.rightBarButtonItem?.title = "Update" 
            nameTextfield.text = selected.name
            descriptionTextfield.text = selected.description
            locationLabel.text = selected.eventLocation?.locationName
            if let startDateTime = selected.startDateTime, let endTime = selected.endTime {
                startDatePicker.setDate(startDateTime, animated: true)
                endDatePicker.setDate(endTime, animated: true)
            }
            if let groups = selected.groups {
                groupTableViewCell.groups = groups
                groupTableViewCell.reload()
            }
            //locationLabel.text = selected.location?.locationName
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
