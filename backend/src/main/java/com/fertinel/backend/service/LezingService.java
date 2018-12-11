package com.fertinel.backend.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.fertinel.backend.data.Lezing;

@Service
public interface LezingService {

	
	Iterable<Lezing> findAll();
	
	Iterable<Lezing> findForUser(int userId);
	
	void save(Lezing lezing);

	Optional<Lezing> findById(int id);
	
	long count();

	Lezing findById(int userId, int id);

	void publish(int id, Lezing editedLezing);
	
}
