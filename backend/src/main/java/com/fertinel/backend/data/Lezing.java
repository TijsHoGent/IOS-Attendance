package com.fertinel.backend.data;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity(name = "Lezing")
@Table(name = "lezingen")
public class Lezing {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int lezingID;

	@Column
	private String name;

	@Column
	private String description;

    @ManyToMany(fetch = FetchType.LAZY ,cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "group_lezing", 
      joinColumns = @JoinColumn(name = "lezing_id"), 
      inverseJoinColumns = @JoinColumn(name = "group_id"))
	private Set<Group> groups = new HashSet<>();

	public Lezing() {
	}

	public int getLezingID() {
		return lezingID;
	}

	public void setLezingID(int lezingID) {
		this.lezingID = lezingID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<Group> getGroups() {
		return groups;
	}

	public void setGroups(Set<Group> groups) {
		this.groups = groups;
	}

	
}
