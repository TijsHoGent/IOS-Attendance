package com.fertinel.backend;

import java.time.LocalDateTime;
import java.time.Month;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.Transactional;

import com.fertinel.backend.data.EventLocation;
import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.Role;
import com.fertinel.backend.data.User;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;
import com.fertinel.backend.repository.UserRepository;

@SpringBootApplication
public class BackendApplication implements CommandLineRunner{

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private LezingRepository lezingRepository;
	
	@Autowired
	private GroupRepository groupRepository;
	
	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}
	@Transactional
	@Override
	public void run(String...args) throws Exception {
	
		Role role = new Role();
		role.setName("Lector");
		Role student = new Role();
		student.setName("Student");
		
		User testLector = new User("testlector", "lector", role);
		
		User testStudent1 = new User("testStudent1", "student", student);
		User testStudent2 = new User("testStudent2", "student", student);
		User testStudent3 = new User("testStudent3", "student", student);
		userRepository.save(testLector);
		userRepository.save(testStudent1);
		userRepository.save(testStudent2);
		userRepository.save(testStudent3);
		
		Group groupA = new Group("Group A");
		groupA.addStudent(testStudent1);
		groupA.addStudent(testStudent2);
		
		Group groupB = new Group("Group B");
		groupB.addStudent(testStudent3);
		
		groupRepository.save(groupA);
		groupRepository.save(groupB);
		
		
		
		// create a lezing
		Lezing l1 = new Lezing(1,"Lezing A", "Description of A", LocalDateTime.of(2018, Month.DECEMBER, 11, 15,00,00), LocalDateTime.of(2018, Month.DECEMBER, 11, 16,45, 00), false);
		l1.addGroup(groupA);
		l1.addGroup(groupB);
		l1.setCreator(testLector);

		lezingRepository.save(l1);
		
		Lezing l2 = new Lezing(2,"Lezing B", "Description of B", LocalDateTime.of(2018, Month.DECEMBER, 11, 16,00,00), LocalDateTime.of(2018, Month.DECEMBER, 20, 16,45, 00), false);
		l2.setCreator(testLector);
		l2.addGroup(groupA);
		lezingRepository.save(l2);
//		
//		Group groupA = new Group(1,"Group A");
//		Group groupB = new Group(2, "Group B");
//		
//		l1.addGroup(groupA);
//		l1.addGroup(groupB);
//
//		l2.addGroup(groupA);
//		
//		lezingRepository.save(l2);
		


	}
}
