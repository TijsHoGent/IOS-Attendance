//
//  Lezing.swift
//  Attendance
//
//  Created by Tijs Fertinel on 24/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation
import MapKit

struct Lezing : Codable{
    
    var lezingID: Int
    var name: String
    var description: String
    var startDateTime: Date?
    var endTime: Date?
    
    var eventLocation:EventLocation?
    
    var published: Bool = false
    var groups: [Group]?
    
    var creator: User
    
    enum LezingKeys: String, CodingKey {
        case lezingID
        case name
        case description
        case startDateTime
        case endTime
        case groups
        case eventLocation
        case creator
        case published
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: LezingKeys.self)
        self.lezingID = try valueContainer.decode(Int.self, forKey: .lezingID)
        self.name = try valueContainer.decode(String.self, forKey: .name)
        self.description = try valueContainer.decode(String.self, forKey: .description)
        self.groups = try? valueContainer.decode(Array<Group>.self, forKey: .groups)
        self.eventLocation = try? valueContainer.decode(EventLocation.self, forKey: .eventLocation)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDateString = try valueContainer.decode(String.self, forKey: .startDateTime)
        
        if let date = formatter.date(from: startDateString) {
            self.startDateTime = date
        }
        
        let endTimeString = try valueContainer.decode(String.self, forKey: .endTime)

        if let time = formatter.date(from: endTimeString) {
            self.endTime = time
        }
        
        self.published = try valueContainer.decode(Bool.self, forKey: .published)
        
        self.creator = try valueContainer.decode(User.self, forKey: .creator)
    }
   
    
    init(lezingID: Int, title: String, description: String, startDate: Date, endDate:Date, location: EventLocation, groups: [Group], creator: User) {
        self.lezingID = lezingID
       self.name = title
        self.description = description
        self.startDateTime = startDate
        self.endTime = endDate
        self.eventLocation = location
        self.groups = groups
        self.creator = creator
    }

    
}

