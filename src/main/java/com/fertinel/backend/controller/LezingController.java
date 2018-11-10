package com.fertinel.backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.dto.LezingDTO;
import com.fertinel.backend.repository.GroupRepository;
import com.fertinel.backend.repository.LezingRepository;
import com.fertinel.backend.service.LezingService;

@RestController
@RequestMapping("/api")
public class LezingController {

	@Autowired
	private LezingService lezingService;
	
	@Autowired
	private GroupRepository groupRepository;
	
	@GetMapping("/lezingen")
	public @ResponseBody List<LezingDTO> getAll() {
		return lezingService.getAll();
	}
	
	@GetMapping("/lezingen/{id}")
	public @ResponseBody LezingDTO getLezing(@PathVariable("id") int id) {
		return lezingService.lezingById(id);
		
	}
	
	@PostMapping("/lezingen/add")
	public Lezing newLezing(@RequestBody Lezing l) {
		lezingService.save(l);
		return l;
	}
	
	

}
