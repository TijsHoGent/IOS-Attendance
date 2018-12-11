//
//  EventInfoTableViewController.swift
//  Attendance
//
//  Created by Tijs Fertinel on 11/12/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit
import MapKit

class EventInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var locationMap: MKMapView!
    
    @objc func registerForEvent() {
        print("registering for \(selectedEvent!.name)" )
    }
    
    
    let registerButton = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerForEvent))
    
    var selectedEvent: Lezing?
    var userLat: Double?
    var userLong: Double?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMap.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
       
        
        self.navigationItem.rightBarButtonItem = registerButton
        registerButton.isEnabled = false
        
        
        if let lezing = selectedEvent {
            self.navigationItem.title = lezing.name
            startDateLabel.text! = lezing.startDateTime!.description
            endTimeLabel.text! = lezing.endTime!.description
            
            if let location = lezing.eventLocation {
                let coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                let anno = MKPointAnnotation()
                anno.coordinate = coordinate
                locationMap.addAnnotation(anno)
                
                let span = MKCoordinateSpanMake(0.0275, 0.0275)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                locationMap.setRegion(region, animated: true)
            }
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateRegisterButton() {
        let range = selectedEvent!.startDateTime!...selectedEvent!.endTime!
        if !range.contains(Date.init()) {
            self.navigationItem.rightBarButtonItem?.title = "Not started Yet"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Register"
            let userLocation = CLLocation(latitude: userLat!, longitude: userLong!)
            let eventLocation = CLLocation(latitude: selectedEvent!.eventLocation!.latitude, longitude: selectedEvent!.eventLocation!.longitude)
            let distance = userLocation.distance(from: eventLocation)
            
            if roundTo200Meters(x: distance) <= 200 {
                registerButton.isEnabled = true
            }
        }
    
    }
    
    func roundTo200Meters(x : Double) -> Int {
        return 200 * Int(round(x / 200.0))
    }
    
}

extension EventInfoTableViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinIdent = "Pin"
        var pinView: MKPinAnnotationView
        if let dequeuedView = locationMap.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            pinView = dequeuedView
        }else{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent)
        }
        return pinView
    }
}

extension EventInfoTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        userLat = location.latitude
        userLong = location.longitude
        updateRegisterButton()
    }
  
}


