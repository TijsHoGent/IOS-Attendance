package com.fertinel.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.fertinel.backend.data.User;

@RepositoryRestResource(collectionResourceRel = "users", path= "users")
public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);
	
}
