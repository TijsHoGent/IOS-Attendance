//
//  LezingService.swift
//  Attendance
//
//  Created by Tijs Fertinel on 10/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

struct LezingService {
    
    func fetchAllLezingen(completion: @escaping ([Lezing]?) -> Void) {
        let baseUrl = URL(string: "http://127.0.0.1:8080/api/lezingen")!
        let task = URLSession.shared.dataTask(with: baseUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let lezingen = try? decoder.decode([Lezing].self, from: data) {
                completion(lezingen)
            } else {
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    static func fetchAllGroups(completion: @escaping ([Group]?) -> Void) {
        let baseUrl = URL(string: "http://127.0.0.1:8080/api/groups")!
        let task = URLSession.shared.dataTask(with: baseUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let groups = try? decoder.decode([Group].self, from: data) {
                completion(groups)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
