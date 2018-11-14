package com.fertinel.backend.service;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;

@Service
public class LezingService {

	@Autowired
	private LezingRepository lezingRepository;
	
	@Autowired
	private GroupRepository groupRepository;
	
	public LezingService() {
	}
	
	public void saveLezing(Lezing l) {
		lezingRepository.save(l);
	}
	
}
