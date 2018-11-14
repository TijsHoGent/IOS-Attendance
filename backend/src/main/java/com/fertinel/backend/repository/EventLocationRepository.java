package com.fertinel.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.fertinel.backend.data.EventLocation;

@RepositoryRestResource(collectionResourceRel="eventlocation", path="eventlocation")
public interface EventLocationRepository extends JpaRepository<EventLocation, Integer>{

}
