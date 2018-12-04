//
//  ViewController.swift
//  Attendance
//
//  Created by Tijs Fertinel on 24/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class LezingTableViewController: UITableViewController {
    
    @IBOutlet var lezingenTableView: UITableView!
    
    @IBAction func addEventPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addEvent", sender: nil)
    }
    
    @IBAction func unwindToEventsTableViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "saveEvent" {
            
            let controller = segue.source as! AddEventTableViewController
            
            guard controller.nameTextfield.text != nil else {return}
            guard controller.descriptionTextfield.text != nil else {return}
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let name = controller.nameTextfield.text!
            let description = controller.descriptionTextfield.text!
            let startDateTime = controller.startDatePicker.date
            let endTime = controller.endDatePicker.date
            //let location = EventLocation(locationName: "test", location: "test", longitude: 3.0, latitude: 5.0)
            let location = controller.location!
            let groups: [Group] = controller.groupTableViewCell.groups
            
            var lezing = Lezing(lezingID: lezingen.count + 1, title: name, description: description, startDate: startDateTime, endDate: endTime, location: location, groups: groups, creator: currentUser!)
            lezing.isPublished = false
            currentUser = lezing.creator
            
            if let selectedIndexPath = lezingenTableView.indexPathForSelectedRow {
                lezing.lezingID = lezingen[selectedIndexPath.row].lezingID
                updateLezing(with: lezing)
            } else {
                saveLezing(lezing: lezing)
            }
        }  else {
            loadLezingen()
        }
        
    }
    
    
    var currentUser: User?
    var lezingen: [Lezing] = []
    let lezingService: LezingService = LezingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLezingen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lezingen.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LezingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LezingCell", for: indexPath) as! LezingTableViewCell
        let event = lezingen[indexPath.row]
        cell.event = event
        cell.delegate = self
        cell.title?.text = event.name
        cell.detail?.text = event.description
        if let published = event.isPublished {
            cell.publishButton.isEnabled = !published
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEvent" {
            let lezing:Lezing = lezingen[lezingenTableView.indexPathForSelectedRow!.row]
            let addEventTableViewController = segue.destination as! AddEventTableViewController
            addEventTableViewController.lezing = lezing
        } 
    }
    
    func updateUI(with lezingen: [Lezing]) {
        self.lezingen = lezingen
    }
    
    func saveLezing(lezing: Lezing) {
        lezingService.addNewLezing(newLezing: lezing) { (lezing) in
            self.loadLezingen()
        }
    }
    
    func updateLezing(with lezing: Lezing) {
        //update lezingen hier
        //lezingService.update()...
        lezingService.updateLezing(updated: lezing) { (lezing) in
            self.loadLezingen()
        }
    }
    
    func publishLezing(_ id: Int) {
        lezingService.publishLezing(id: id) { () in
            self.loadLezingen()
        }
    }
    
    func loadLezingen() {
        lezingService.fetchAllLezingen(user: currentUser!, completion:  { (lezingen) in
            if let lezingen = lezingen {
                self.lezingen = lezingen
                DispatchQueue.main.async {
                    self.lezingenTableView.reloadData()
                }
            }
        })
    }
    
    
    
}

extension LezingTableViewController: LezingTableViewCellDelegate {
    func publishPressed(sender: LezingTableViewCell) {
        self.publishLezing(sender.event!.lezingID)
    }
}

