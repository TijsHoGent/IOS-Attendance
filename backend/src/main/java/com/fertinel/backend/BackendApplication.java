package com.fertinel.backend;

import com.fertinel.backend.data.EventLocation;
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

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;

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
		l1.setStartDateTime(LocalDateTime.of(2019, Month.NOVEMBER, 15, 15,00,00));
		l1.setEndTime(LocalTime.of(16,45,00));

		EventLocation location = new EventLocation();
		location.setLocation("Ghent");
		location.setLocationName("Hogent schoonmeerschen");
		location.setLongitude(3.7018883228302002);
		location.setLatitude(51.03134887142105);


		Group g1 = new Group();
		g1.setGroupName("Group A");
	
		l1.getGroups().add(g1);
		l1.setEventLocation(location);
		g1.getLezingen().add(l1);
		lezingService.save(l1);
	}
}
