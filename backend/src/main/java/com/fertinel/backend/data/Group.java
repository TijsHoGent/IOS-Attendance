package com.fertinel.backend.data;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity(name = "Group")
@Table(name = "classgroups")
public class Group{

	@Id
	private int groupID;
	
	@Column(name="groupName")
	private String groupName;
	
	@ManyToMany(mappedBy="groups", cascade = {CascadeType.PERSIST})
	@JsonIgnore
	private Set<Lezing> lezingen = new HashSet<>();
	
	public Group() {
	}
	
	public Group(int groupID, String groupName) {
		this.groupID = groupID;
		this.groupName = groupName;
	}

	
	public Group(int groupID, String name, Set<Lezing> lezingen) {
		this.groupID = groupID;
		this.groupName = name;
		this.lezingen = lezingen;
	}

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Set<Lezing> getLezingen() {
		return lezingen;
	}

	
	
}
