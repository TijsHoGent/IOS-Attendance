package com.fertinel.backend.controller;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.Group;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;
import com.fertinel.backend.repository.UserRepository;
import com.fertinel.backend.service.LezingService;

@RestController
@RequestMapping("/api")
public class LezingController {

	@Autowired
	private LezingService lezingService;
	
	@Autowired 
	private GroupRepository groupRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@GetMapping("/lezingen/{userId}")
	public @ResponseBody Iterable<Lezing> getAll(@PathVariable("userId") String userId) {
		int uId = Integer.parseInt(userId);
		return lezingService.findForUser(uId);
	}
	
	@GetMapping("/lezingen/{userId}/lezing/{id}")
	public @ResponseBody Lezing getLezing(@PathVariable("userId") int userId, @PathVariable("id") int id) {
		return lezingService.findById(userId, id);
		
	}
	@PostMapping("/lezingen/add")
	public Lezing newLezing(@RequestBody Lezing l) {
		
		Lezing newLezing = new Lezing((int) lezingService.count() + 1,l.getName(), l.getDescription(), l.getStartDateTime(), l.getEndTime(), false);
		newLezing.setCreator(l.getCreator());
		newLezing.setEventLocation(l.getEventLocation());
		l.getGroups().forEach(g -> {
			Optional<Group> dbGroup = groupRepository.findById(g.getGroupID());
			newLezing.addGroup(dbGroup.get());
		});
		

		lezingService.save(newLezing);
		
		return newLezing;
	}
	
	@PutMapping("/lezingen/{id}") 
	public ResponseEntity<Lezing> updateLezing(@PathVariable int id, @RequestBody Lezing lezing) {
		
		Optional<Lezing> dbLezing = lezingService.findById(id);
		
		if(!dbLezing.isPresent()) {
			return ResponseEntity.notFound().build();
		}
		
		lezing.setLezingID(id);
		
		lezingService.save(lezing);
		
		return ResponseEntity.noContent().build();
	}
	
	@PatchMapping("/lezingen/{id}/publish")
	public ResponseEntity<Resource<Lezing>> publishLezing(@PathVariable("id") int id, @RequestBody Lezing publishedLezing) {
		lezingService.publish(id, publishedLezing);
		
		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}

}
