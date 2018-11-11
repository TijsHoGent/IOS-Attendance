package com.fertinel.backend.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int lezingID;

	@Column
	private String name;

	@Column
	private String description;

	@Column
	private LocalDateTime startDateTime;

	@Column
	private LocalTime endTime;

	@OneToOne(fetch = FetchType.LAZY)
	@MapsId
	@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
	private EventLocation eventLocation;

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

	public LocalDateTime getStartDateTime() {
		return startDateTime;
	}

	public void setStartDateTime(LocalDateTime startDateTime) {
		this.startDateTime = startDateTime;
	}

	public LocalTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalTime endTime) {
		this.endTime = endTime;
	}

	public EventLocation getEventLocation() {
		return eventLocation;
	}

	public void setEventLocation(EventLocation eventLocation) {
		this.eventLocation = eventLocation;
	}
}
