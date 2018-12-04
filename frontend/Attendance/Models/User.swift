//
//  User.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

struct Role : Codable {
    var id: Int
    var name: String
    
    enum RoleKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: RoleKeys.self)
        try self.id = valueContainer.decode(Int.self, forKey: .id)
        try self.name = valueContainer.decode(String.self, forKey: .name)
    }
}

class User : Codable{

    
    enum UserKeys: String, CodingKey {
        case id
        case username
        case password
        case role
    }
    var id: Int?
    var username: String
    var password: String
    var role:Role?
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: UserKeys.self)
        try self.username = valueContainer.decode(String.self, forKey: .username)
        try self.password = valueContainer.decode(String.self, forKey: .password)
        try self.id = valueContainer.decode(Int.self, forKey: .id)
        try self.role = valueContainer.decode(Role.self, forKey: .role)
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.role = nil
        
    }
    
    init(username: String, password: String, role: Role) {
        self.username = username
        self.password = password
        self.role = role
    }
    
}
