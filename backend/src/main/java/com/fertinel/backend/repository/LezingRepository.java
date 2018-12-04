package com.fertinel.backend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

import com.fertinel.backend.data.Lezing;

@RepositoryRestResource(collectionResourceRel = "lezing", path= "lezing")
public interface LezingRepository extends JpaRepository<Lezing, Integer>{

	@Query("select l from Lezing l where l.creator.id = ?1")
	List<Lezing> findAllForCreator(Integer id); 
}
