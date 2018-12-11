package com.fertinel.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.User;
import com.fertinel.backend.repository.LezingRepository;
import com.fertinel.backend.repository.UserRepository;

@Service
public class LezingServiceImpl implements LezingService {

	@Autowired
	private LezingRepository lezingRepository;

	@Autowired
	private UserRepository userRepository;

	@Override
	public Iterable<Lezing> findAll() {
		return lezingRepository.findAll();
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
		return lezingRepository.findById(id).get();
	}

	@Override
	public Iterable<Lezing> findForUser(int userId) {
		User user = userRepository.findById(userId).get();
		switch (user.getRole().getName()) {
		case "Lector":
			return lezingRepository.findByCreator(user);
		case "Student":
			return lezingRepository.findByGroupsAndPublished(user.getGroup());

		}
		return lezingRepository.findByCreator(user);
	}

	@Override
	public void publish(int id, Lezing editedLezing) {

		lezingRepository.saveAndFlush(editedLezing);
	}

}
