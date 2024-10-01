package com.RentalApplication.service;

import java.util.List;
import java.util.Optional;

import com.RentalApplication.model.Property;

public interface PropertyService {
    Property createProperty(Property property);
    Optional<Property> getPropertyById(Integer id);
    List<Property> getAllProperties();
    Property updateProperty(Integer id, Property property);
    void deleteProperty(Integer id);
    Property saveProperty(Property property);
	List<Property> searchProperties(String query, String field);
}