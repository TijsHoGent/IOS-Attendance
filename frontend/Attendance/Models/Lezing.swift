//
//  Lezing.swift
//  Attendance
//
//  Created by Tijs Fertinel on 24/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation
import MapKit

struct Lezing :Codable{
    
    var title: String
    var description: String
    var startDate: Date?
    var endDate: Date?
    
    var location:EventLocation?
    
    var isPublished: Bool?
    var groups: [Group]?
    
    enum LezingKeys: String, CodingKey {
        case name
        case description
        case startDateTime
        case endTime
        case groups
        case eventLocation
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: LezingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: .name)
        self.description = try valueContainer.decode(String.self, forKey: .description)
        self.groups = try? valueContainer.decode(Array<Group>.self, forKey: .groups)
        self.location = try? valueContainer.decode(EventLocation.self, forKey: .eventLocation)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        let startDateString = try valueContainer.decode(String.self, forKey: .startDateTime)
        
        if let date = formatter.date(from: startDateString) {
            self.startDate = date
        }
        
        
        let endTimeString = try valueContainer.decode(String.self, forKey: .endTime)
        let endTimeFormatter = DateFormatter.hhmmss
        
        
        if let time = endTimeFormatter.date(from: endTimeString) {
            self.endDate = time
        }
        
    }
    
    init(title: String, description: String, startDate: Date, endDate:Date) {
       self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
    
}

extension DateFormatter {
    static let ddMMyyyyhhmmss: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "nl_BE_POSIX")
        return formatter
    }()
    
    static let hhmmss: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "nl_BE_POSIX")
        return formatter
    }()
}
