package com.fertinel.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fertinel.backend.data.Group;

@Repository
public interface GroupRepository extends JpaRepository<Group, Integer>{

}
