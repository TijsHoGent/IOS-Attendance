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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity(name = "Group")
@Table(name = "classgroups")
public class Group{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int groupID;
	
	@Column(name="groupName")
	private String groupName;
	
	@ManyToMany(mappedBy="groups", cascade = {CascadeType.MERGE})
	@JsonIgnore
	private Set<Lezing> lezingen = new HashSet<>();
	
	@OneToMany(mappedBy="group", targetEntity= User.class, cascade = {CascadeType.MERGE})
	private Set<User> students = new HashSet<>();
	
	public Group() {
	}
	
	public Group( String groupName) {
		this.groupName = groupName;
	}

	
	public Group(String groupName, Set<User> students) {
		this(groupName);
		this.students = students;
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

	public void addStudent(User s) {
		this.students.add(s);
		s.setGroup(this);
	}

	public void setStudents(Set<User> students) {
		this.students = students;
	}

	
	
}
