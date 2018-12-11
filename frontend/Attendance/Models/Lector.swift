//
//  Lector.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

class Lector: User {
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}
