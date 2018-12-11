package com.fertinel.backend.repository;

import java.util.List;

import org.jboss.logging.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;
import com.fertinel.backend.data.User;

@RepositoryRestResource(collectionResourceRel = "lezing", path= "lezing")
public interface LezingRepository extends JpaRepository<Lezing, Integer>{

	@Query("select l from Lezing l where l.creator = ?1")
	List<Lezing> findByCreator(User user); 
	
	@Query("select l from Group g join g.lezingen l where g = ?1 and l.published = 1 ")
	List<Lezing> findByGroupsAndPublished(Group group);
}
