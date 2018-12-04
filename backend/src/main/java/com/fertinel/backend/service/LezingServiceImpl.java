package com.fertinel.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.repository.LezingRepository;
import com.fertinel.backend.repository.UserRepository;

@Service
public class LezingServiceImpl implements LezingService{

	@Autowired
	private LezingRepository lezingRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public Iterable<Lezing> findAll() {
		return lezingRepository.findAll();
	}

	@Override
	public Lezing publish(int lezingId) {
		Optional<Lezing> lezing = lezingRepository.findById(lezingId);
		if(lezing.isPresent()) {
			Lezing l = lezing.get();
			if(!l.isPublished()) {
				lezing.get().setPublished(true);
			}
		}
		return lezingRepository.saveAndFlush(lezing.get());
	}

	@Override
	public void save(Lezing lezing) {
		lezingRepository.save(lezing);
	}

	@Override
	public Optional<Lezing> findById(int id) {
		return lezingRepository.findById(id);
	}

	@Override
	public long count() {
		return lezingRepository.count();
	}

	@Override
	public Lezing findById(int userId, int id) {
		List<Lezing> lezingen = lezingRepository.findAllForCreator(userId);
		
		return lezingen.stream().filter(lezing -> lezing.getLezingID() == id).findFirst().get();
	}

	@Override
	public Iterable<Lezing> findByCreator(int userId) {
		return lezingRepository.findAllForCreator(userId);
	}


	
}
