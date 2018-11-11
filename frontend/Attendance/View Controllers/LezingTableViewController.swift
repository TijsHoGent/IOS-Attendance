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
    
    let lezingService: LezingService = LezingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lezingService.fetchAllLezingen { (lezingen) in
            self.lezingen = lezingen!
            DispatchQueue.main.async {
                self.lezingenTableView.reloadData()
            }
        }
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

    func updateUI(with lezingen: [Lezing]) {
        self.lezingen = lezingen
    }
    
    func saveLezingen() {}

    func loadLezingen() {
        
    }

}

