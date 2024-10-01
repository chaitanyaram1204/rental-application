package com.RentalApplication.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.RentalApplication.model.Photos;

import java.util.List;

public interface PhotosRepository extends JpaRepository<Photos, Integer> {
    List<Photos> findAllByPropertyId(Integer propertyId); // Custom query to find all photos by property ID
}
