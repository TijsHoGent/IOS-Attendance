package com.fertinel.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.fertinel.backend.data.Lezing;
@Repository
public interface LezingRepository extends JpaRepository<Lezing, Integer>{

}
