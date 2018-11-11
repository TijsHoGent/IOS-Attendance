//
//  Group.swift
//  Attendance
//
//  Created by Tijs Fertinel on 31/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    var groupName: String
    
    enum GroupKeys : String, CodingKey{
        case groupName
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: GroupKeys.self)
        self.groupName = try valueContainer.decode(String.self, forKey: .groupName)
    }
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
}
