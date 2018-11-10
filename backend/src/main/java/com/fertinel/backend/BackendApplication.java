package com.fertinel.backend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.dto.LezingDTO;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;
import com.fertinel.backend.service.LezingService;

@SpringBootApplication
public class BackendApplication implements CommandLineRunner{

	@Autowired
	private LezingService lezingService;
	
	@Autowired 
	private GroupRepository groupRepository;
	
	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}
	
	@Override
	public void run(String...args) throws Exception {
	
		groupRepository.deleteAllInBatch();
		
		// create a lezing
		Lezing l1 = new Lezing();
		l1.setName("Lezing A");
		l1.setDescription("Description of A");
		
		Group g1 = new Group();
		g1.setGroupName("Group A");
	
		l1.getGroups().add(g1);
		
		g1.getLezingen().add(l1);
		
		lezingService.save(l1);
	}
}
