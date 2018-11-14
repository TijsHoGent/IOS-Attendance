package com.fertinel.backend;

import com.fertinel.backend.data.EventLocation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.Transactional;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.repository.EventLocationRepository;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.HashSet;
import java.util.Set;

@SpringBootApplication
public class BackendApplication implements CommandLineRunner{

	@Autowired
	private LezingRepository lezingRepository;
	
	@Autowired 
	private GroupRepository groupRepository;
	
	@Autowired
	private EventLocationRepository eventLocationRepository;
	
	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}
	@Transactional
	@Override
	public void run(String...args) throws Exception {
	
		// create a lezing
		Lezing l1 = new Lezing(1,"Lezing A", "Description of A", LocalDateTime.of(2019, Month.NOVEMBER, 15, 15,00,00), LocalDateTime.of(2019, Month.NOVEMBER, 16, 16,45, 00));
		Lezing l2 = new Lezing(2,"Lezing B", "Description of B", LocalDateTime.of(2019, Month.NOVEMBER, 16, 15,00,00), LocalDateTime.of(2019, Month.NOVEMBER, 16, 16,45, 00));


		lezingRepository.save(l1);
		lezingRepository.save(l2);
		
		Group groupA = new Group(1,"Group A");
		Group groupB = new Group(2, "Group B");
		
		
		EventLocation location = new EventLocation("Ghent", "Hogent Schoonmeerschen", 3.7018883228302002, 51.03134887142105);
	
		
		l1.setEventLocation(location);
		l1.addGroup(groupA);
		l1.addGroup(groupB);

		l2.addGroup(groupA);
		l2.setEventLocation(location);


		lezingRepository.save(l1);
		lezingRepository.save(l2);

	}
}
