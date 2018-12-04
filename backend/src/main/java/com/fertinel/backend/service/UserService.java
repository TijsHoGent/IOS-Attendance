package com.fertinel.backend.service;

import java.util.Optional;

import com.fertinel.backend.data.User;

public interface UserService {

	User findByUsername(String username);
	
	
}
