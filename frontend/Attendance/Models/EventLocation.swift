//
//  Location.swift
//  Attendance
//
//  Created by Tijs Fertinel on 31/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation
import MapKit

struct EventLocation :Codable{
    var locationName: String
    var location: String
    
    var longitude: Double
    var latitude: Double
    
    enum LocationKeys: String, CodingKey {
        case locationName
        case location
        case longitude
        case latitude
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: LocationKeys.self)
        self.locationName = try valueContainer.decode(String.self, forKey: .locationName)
        self.location = try valueContainer.decode(String.self, forKey: .location)
        self.longitude = try valueContainer.decode(Double.self, forKey: .longitude)
        self.latitude = try valueContainer.decode(Double.self, forKey: .latitude)
    }
    
    init(locationName:String, location: String, longitude: Double, latitude:Double) {
        self.locationName = locationName
        self.location = location
        self.longitude = longitude
        self.latitude = latitude
    }
    
    static func defaultLocation() -> EventLocation {
        return EventLocation(locationName: "Hogeschool Gent", location: "Gent", longitude: 50.00, latitude: 26.00)
    }
}
