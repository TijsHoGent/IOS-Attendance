package com.fertinel.backend.data;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.*;

@Entity(name = "Lezing")
@Table(name = "lezingen")
public class Lezing {

	@Id
	private int lezingID;

	@Column
	private String name;

	@Column
	private String description;

	@Column
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime startDateTime;

	@Column
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime endTime;

	@OneToOne(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name = "location_id")
	private EventLocation eventLocation;

    @ManyToMany(fetch = FetchType.LAZY ,cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "group_lezing", 
      joinColumns = @JoinColumn(name = "lezing_id"), 
      inverseJoinColumns = @JoinColumn(name = "group_id"))
	private Set<Group> groups = new HashSet<>();

	public Lezing() {
	}

	public Lezing(int id, String name, String description, LocalDateTime startDateTime, LocalDateTime endTime) {
		this.lezingID = id;
		this.name = name;
		this.description = description;
		this.startDateTime = startDateTime;
		this.endTime = endTime;
	}



	public Lezing(String name, String description, LocalDateTime startDateTime, LocalDateTime endTime,
			EventLocation eventLocation, Set<Group> groups) {
		this.name = name;
		this.description = description;
		this.startDateTime = startDateTime;
		this.endTime = endTime;
		this.eventLocation = eventLocation;
		this.groups = groups;
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

	public void addGroup(Group g) {
		this.groups.add(g);
		g.getLezingen().add(this);
	}
	
	public void removeGroup(Group g) {
		this.groups.remove(g);
		g.getLezingen().remove(this);
	}
	
	public void remove() {
		for(Group g: new HashSet<>(groups)) {
			removeGroup(g);
		}
	}
	
	public Set<Group> getGroups() {
		return groups;
	}

	public LocalDateTime getStartDateTime() {
		return startDateTime;
	}

	public void setStartDateTime(LocalDateTime startDateTime) {
		this.startDateTime = startDateTime;
	}

	public LocalDateTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalDateTime endTime) {
		this.endTime = endTime;
	}

	public EventLocation getEventLocation() {
		return eventLocation;
	}

	public void setEventLocation(EventLocation e) {
		this.eventLocation = e;
	}
}
