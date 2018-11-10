package com.fertinel.backend.data.dto;

import java.util.Set;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;

public class LezingDTO {

	private int id;
	private String name;
	private String description;
	
	private Set<Group> groups;
	
	public LezingDTO(Lezing lezing) {
		setId(lezing.getLezingID());
		setName(lezing.getName());
		setDescription(lezing.getDescription());
		setGroups(lezing.getGroups());
	}

	public int getId() {
		return id;
	}

	private void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	private void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	private void setDescription(String description) {
		this.description = description;
	}

	public Set<Group> getGroups() {
		return groups;
	}

	private void setGroups(Set<Group> groups) {
		this.groups = groups;
	}
	
	
	
}
