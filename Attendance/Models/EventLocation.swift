//
//  Location.swift
//  Attendance
//
//  Created by Tijs Fertinel on 31/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

struct EventLocation {
    var locationName: String!
    var location: String!
    
    init(locationName:String, location: String) {
        self.locationName = locationName
        self.location = location
    }
}
