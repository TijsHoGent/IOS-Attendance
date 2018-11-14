package com.fertinel.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

import com.fertinel.backend.data.Group;


@RepositoryRestResource(collectionResourceRel = "group", path= "group")
public interface GroupRepository extends JpaRepository<Group, Integer>{

}
