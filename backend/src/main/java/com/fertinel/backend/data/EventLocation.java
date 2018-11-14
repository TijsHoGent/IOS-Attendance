package com.fertinel.backend.data;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "EventLocations")
public class EventLocation {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column
    private String locationName;
    @Column
    private String location;
    @Column
    private double longitude;
    @Column
    private double latitude;

    @OneToMany(fetch=FetchType.LAZY, cascade = {CascadeType.PERSIST})
    @JoinColumn(name="fk_lezing")
    @JsonIgnore
    private Set<Lezing> lezingen = new HashSet<>();

    public EventLocation() {
    }
    

    public EventLocation(String locationName, String location, double longitude, double latitude) {

		this.locationName = locationName;
		this.location = location;
		this.longitude = longitude;
		this.latitude = latitude;
	}



	public EventLocation(String locationName, String location, double longitude, double latitude,
			Set<Lezing> lezingen) {

		this.locationName = locationName;
		this.location = location;
		this.longitude = longitude;
		this.latitude = latitude;
		this.lezingen = lezingen;
	}


	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

	public Set<Lezing> getLezingen() {
		return lezingen;
	}

	public void addLezing(Lezing l) {
		this.lezingen.add(l);
	}
    
}
