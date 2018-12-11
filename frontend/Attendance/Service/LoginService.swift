//
//  LoginService.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import Foundation
import Alamofire


class LoginService: Service<User> {
    
    func login(username: String, password: String, onSuccess: @escaping (User) -> Void, onError: @escaping () -> Void) {
        let baseUrl = URL(string: "http://127.0.0.1:8080/api/login?username=\(username)&password=\(password)")!

        let parameters: Parameters = [
            "username": username,
            "password": password,
        ]
        
        Alamofire.request(baseUrl)
            .responseJSON { (response) in
                let decoder = JSONDecoder()
                if let userData = response.data , let user = try? decoder.decode(User.self, from: userData){
                    if let role = user.role {
                        switch(role.name) {
                        case "Lector":
                            onSuccess(try! decoder.decode(Lector.self, from: userData))
                        case "Student":
                            onSuccess(try! decoder.decode(Student.self, from: userData))
                        default:
                            onError()
                        }
                    }
                }
        }
        
    }
    
}
