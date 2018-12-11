//
//  Service.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation

class Service<T: Codable> {
    
    
    func doRequest(method: String, url: String, object: T?, whenParsed: @escaping (URLRequest, Data) -> Void) {
        let baseURL = URL(string: url)!
        var request = URLRequest(url: baseURL)
        
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        if let object = object {
            let jsonData = try? encoder.encode(object)
            
            request.httpBody = jsonData
            whenParsed(request, jsonData!)
        }
        
    }
    
    func encode(object: T?) -> Data {
        let encoder = JSONEncoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        let jsonData = try! encoder.encode(object)
        return jsonData
    }
}
