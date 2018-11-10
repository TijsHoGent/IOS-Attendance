//
//  Lezing.swift
//  Attendance
//
//  Created by Tijs Fertinel on 24/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation
import MapKit

class Lezing {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    
    var location:EventLocation?
    
    var isPublished: Bool
    var groups: [String] = []
    
    init(title: String, description:String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.isPublished = false
    }
    
    func addGroup(group: String) {
        groups.append(group)
    }
    
}
