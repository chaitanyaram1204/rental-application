package com.RentalApplication.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.RentalApplication.model.Property;

public interface PropertyRepository extends JpaRepository<Property, Integer> {
    // Add custom query methods if needed
	List<Property> findByHostId(Integer hostId);
	List<Property> findByNameContainingIgnoreCase(String name);
    List<Property> findByCategoryContainingIgnoreCase(String category);
    List<Property> findByLocationContainingIgnoreCase(String location);
}