package com.fertinel.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.dto.LezingDTO;
import com.fertinel.backend.repository.LezingRepository;

@Service
public class LezingService {
	
	@Autowired
	private LezingRepository lezingRepository;
	
	public List<LezingDTO> getAll() {
		return lezingRepository.findAll().stream().map(LezingDTO::new).collect(Collectors.toList());
	}

	public void save(Lezing l) {
		lezingRepository.save(l);
	}

	public LezingDTO lezingById(int id) {
		Optional<Lezing> optLezing = lezingRepository.findById(id);
		return new LezingDTO(optLezing.get());
	}

}
