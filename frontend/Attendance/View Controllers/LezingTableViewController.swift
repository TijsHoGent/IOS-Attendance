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
    var lezingen: [Lezing] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lezingen = [
            Lezing(title: "lezing", description: "lezing A", startDate: Date(), endDate: Date()),
            Lezing(title: "lezing b", description: "lezing b", startDate: Date(), endDate: Date()),
            Lezing(title: "lezing c", description: "lezing A", startDate: Date(), endDate: Date())
        ]
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return lezingen.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LezingCell", for: indexPath)
        let event = lezingen[indexPath.row]
        cell.textLabel?.text = event.title
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

    func saveLezingen() {}

    func loadLezingen() {}

}

