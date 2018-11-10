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
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity(name = "Group")
@Table(name = "classgroups")
public class Group {

	@Id
	@GeneratedValue
	private int groupID;
	
	@Column(name="groupName")
	private String groupName;
	
	@ManyToMany(fetch= FetchType.LAZY, 
			cascade = {CascadeType.PERSIST, CascadeType.PERSIST},
			mappedBy="groups")
	@JsonIgnore
	private Set<Lezing> lezingen = new HashSet<>();
	
	public Group() {
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

	public void setLezingen(Set<Lezing> lezingen) {
		this.lezingen = lezingen;
	}


	
}
