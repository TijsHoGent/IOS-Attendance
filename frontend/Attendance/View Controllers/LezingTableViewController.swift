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
            if let lezing = controller.lezing {
                //updateLezing(with: lezing)
            } else {
                guard controller.nameTextfield.text != nil else {return}
                guard controller.descriptionTextfield.text != nil else {return}
                //guard controller.location != nil else {return}
                
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let name = controller.nameTextfield.text!
                let description = controller.descriptionTextfield.text!
                let startDateTime = controller.startDatePicker.date
                let endTime = controller.endDatePicker.date
                let location = controller.location!
                let groups: [Group] = controller.groupTableViewCell.groups
                
                let lezing = Lezing(lezingID: lezingen.count + 1, title: name, description: description, startDate: startDateTime, endDate: endTime, location: location, groups: groups)
                
                saveLezing(lezing: lezing)
                
            }
        } else {
            loadLezingen()
        }
    }
    
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LezingCell", for: indexPath)
        let event = lezingen[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.description
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
        // opslaan van lezing hier
        lezingService.addNewLezing(newLezing: lezing) { (lezing) in
            self.loadLezingen()
        }
    }

    func updateLezing(with lezing: Lezing) {
        //update lezingen hier
        //lezingService.update()...
    }
    
    func loadLezingen() {
        lezingService.fetchAllLezingen { (lezingen) in
            if let lezingen = lezingen {
                self.lezingen = lezingen
                DispatchQueue.main.async {
                    self.lezingenTableView.reloadData()
                }
            }
        }
    }
    
}

