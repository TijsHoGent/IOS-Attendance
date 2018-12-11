//
//  Student.swift
//  Attendance
//
//  Created by Tijs Fertinel on 24/10/18.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

class Student: User {
    
    var group: Group
    
    enum StudentKeys: String, CodingKey {
        case group
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StudentKeys.self)
        self.group = try container.decode(Group.self, forKey: .group)
        try super.init(from: decoder)
    }
    
}
