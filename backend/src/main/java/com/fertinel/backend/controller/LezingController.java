package com.fertinel.backend.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fertinel.backend.data.EventLocation;
import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.repository.EventLocationRepository;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;

@RestController
@RequestMapping("/api")
public class LezingController {

	@Autowired
	private LezingRepository lezingRepository;
	
	@Autowired
	private GroupRepository groupRepository;
	
	@Autowired 
	private EventLocationRepository eventLocationRepository;
	
	@GetMapping("/lezingen")
	public @ResponseBody Iterable<Lezing> getAll() {
		return lezingRepository.findAll();
	}
	
	@GetMapping("/lezingen/{id}")
	public @ResponseBody Lezing getLezing(@PathVariable("id") int id) {
		return lezingRepository.findById(id).get();
		
	}
	@PostMapping("/lezingen/add")
	public Lezing newLezing(@RequestBody Lezing l) {
		
		Lezing newLezing = new Lezing((int) lezingRepository.count() + 1,l.getName(), l.getDescription(), l.getStartDateTime(), l.getEndTime());
		
		newLezing.setEventLocation(l.getEventLocation());
		l.getGroups().forEach(g -> {
			Optional<Group> dbGroup = groupRepository.findById(g.getGroupID());
			newLezing.addGroup(dbGroup.get());
		});
		

		lezingRepository.save(newLezing);
		
		return newLezing;
	}
	
	

}
