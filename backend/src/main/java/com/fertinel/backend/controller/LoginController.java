package com.fertinel.backend.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fertinel.backend.data.User;
import com.fertinel.backend.service.UserService;

@RestController
@RequestMapping("/api")
public class LoginController {

	@Autowired
	private UserService userService;
	
	@GetMapping(path= "/login", params = {"username", "password"})
	public @ResponseBody User login(@RequestParam(value="username") String username, @RequestParam(value="password")String password) {
		User dbUser = userService.findByUsername(username);
		if(dbUser == null) {
			return null;
		}
		System.out.println(username + " " + password);
		if(dbUser.getPassword() == password) {
			//System.out.println(dbUser.getId() + " " + dbUser.getRole() + " " + dbUser.getPassword());
			return dbUser;
		}
		return dbUser;
	}
	
}
