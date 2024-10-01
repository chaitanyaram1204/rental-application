package com.RentalApplication.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.RentalApplication.model.Property;
import com.RentalApplication.repository.PropertyRepository;

@Service
public class PropertyServiceImp implements PropertyService{
	 	@Autowired
	    private PropertyRepository propertyRepository;

	    @Override
	    public Property createProperty(Property property) {
	        return propertyRepository.save(property);
	    }

	    @Override
	    public Optional<Property> getPropertyById(Integer id) {
	        return propertyRepository.findById(id);
	    }

	    @Override
	    public List<Property> getAllProperties() {
	        return propertyRepository.findAll();
	    }

	    @Override
	    public Property updateProperty(Integer id, Property property) {
	        if (propertyRepository.existsById(id)) {
	            property.setId(id);
	            return propertyRepository.save(property);
	        } else {
	            return null; // Handle this case as per your requirements
	        }
	    }

	    @Override
	    public void deleteProperty(Integer id) {
	        propertyRepository.deleteById(id);
	    }

		@Override
		public Property saveProperty(Property property) {
		         return propertyRepository.save(property);
		     }
		
		public List<Property> searchProperties(String field, String query) {
	        switch (field) {
	            case "propertyName":
	                return propertyRepository.findByNameContainingIgnoreCase(query);
	            case "category":
	                return propertyRepository.findByCategoryContainingIgnoreCase(query);
	            case "location":
	                return propertyRepository.findByLocationContainingIgnoreCase(query);
	            default:
	                return new ArrayList<>();
	        }
	    }

		}
	
