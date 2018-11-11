//
//  LocationSearchTableViewController.swift
//  Attendance
//
//  Created by Tijs Fertinel on 31/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var locations: [EventLocation] = []
    var selectedLocation: EventLocation?
    
    @IBOutlet var locationTableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        updateDoneButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let location:EventLocation = locations[indexPath.row]
        cell.textLabel?.text = location.locationName
        cell.detailTextLabel?.text = location.location
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLocation = locations[indexPath.row]
        updateDoneButton()
    }
    

    func updateDoneButton() {
        if let selected = selectedLocation {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    
    func search(text: String) {
        let request = MKLocalSearchRequest()
        let locationManager = CLLocationManager()
        //guard let coordinate = locationManager.location?.coordinate else {return}
        //request.region = MKCoordinateRegionMakeWithDistance(coordinate, 3200, 3200)
        request.naturalLanguageQuery = text
        
        MKLocalSearch(request: request).start {
            (response, error) in
            guard error == nil else {return}
            guard let response = response else {return}
            guard response.mapItems.count > 0 else {return}
            
            let locationResponses: [MKMapItem] = response.mapItems
            self.locations = []
            for location in locationResponses {
                let eventLocation: EventLocation = EventLocation(locationName: location.name!, location: location.placemark.locality!, longitude: location.placemark.coordinate.longitude, latitude: location.placemark.coordinate.latitude)
                self.locations.append(eventLocation)
            }
             self.locationTableView.reloadData()
        }
    }
    
  
    func updateSearchResults(for searchController: UISearchController) {
        let searchText:String? = searchController.searchBar.text
        search(text: searchText!)
    }

}
