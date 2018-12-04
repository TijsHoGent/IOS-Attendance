//
//  LezingService.swift
//  Attendance
//
//  Created by Tijs Fertinel on 10/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

class LezingService: Service<Lezing> {

    
    func fetchAllLezingen(user: User, completion: @escaping ([Lezing]?) -> Void) {
        let baseUrl = URL(string: "http://127.0.0.1:8080/api/lezingen/\(user.id!)")!
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
    
    func publishLezing(id: Int, completion: @escaping () -> Void) {
        doRequest(method: "PATCH", url: "http://127.0.0.1:8080/api/lezingen/\(id)/publish", object: nil) { (request, jsonData) in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                completion()
            }
            task.resume()
        }
    }
    
    func updateLezing(updated: Lezing, completion: @escaping (Lezing) -> Void) {
        doRequest(method: "PUT", url: "http://127.0.0.1:8080/api/lezingen/\(updated.creator.id!)/\(updated.lezingID)", object: updated) { (request, jsonData) in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                completion(updated)
            }
            task.resume()
        }
    }
    
    func addNewLezing(newLezing: Lezing, completion: @escaping (Lezing) -> Void) {

        
        doRequest(method: "POST", url: "http://127.0.0.1:8080/api/lezingen/add", object: newLezing) { (request, jsonData) in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                completion(newLezing)
            }
            task.resume()
        }
    
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
