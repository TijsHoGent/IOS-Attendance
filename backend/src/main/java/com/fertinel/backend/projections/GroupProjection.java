package com.fertinel.backend.projections;

import java.util.Set;

import org.springframework.data.rest.core.config.Projection;

import com.fertinel.backend.data.Group;
import com.fertinel.backend.data.Lezing;

@Projection(name = "groups", types = {Group.class})
public interface GroupProjection {
	
	String getGroupName();
	
	Set<Lezing> getLezingen();
}
