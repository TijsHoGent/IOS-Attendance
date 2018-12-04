//
//  LoginService.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation



class LoginService: Service<User> {
    
    func login(username: String, password: String, onSuccess: @escaping (User) -> Void, onError: @escaping () -> Void) {
        let baseUrl = URL(string: "http://127.0.0.1:8080/api/login?username=\(username)&password=\(password)")!

        let task = URLSession.shared.dataTask(with: baseUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data , let user = try? decoder.decode(User.self, from: data) {
                print(user.role!)
                print(user.id!)
                onSuccess(user)
            } else {
                onError()
                return
            }
        }
        task.resume()
        
    }
    
}
