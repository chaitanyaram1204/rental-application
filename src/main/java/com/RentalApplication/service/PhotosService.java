package com.RentalApplication.service;

import com.RentalApplication.model.Photos;
import com.RentalApplication.model.Property;
import com.RentalApplication.repository.PhotosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class PhotosService {

    @Autowired
    private PhotosRepository photosRepository;

    // Save a photo associated with a property
    public Photos savePhoto(MultipartFile file, Integer propertyId, Optional<Property> propertyOpt) throws IOException {
        if (!propertyOpt.isPresent()) {
            throw new IllegalArgumentException("Property not found for ID: " + propertyId);
        }

        Property property = propertyOpt.get();
        
        Photos photo = new Photos();
        photo.setImage(file.getBytes()); // Set the image as a blob
        photo.setProperty(property);     // Associate with the property
        
        return photosRepository.save(photo); // Save the photo in the repository
    }

    // Retrieve a photo by ID
    public Photos getPhotoById(Integer id) {
        return photosRepository.findById(id).orElse(null); // Return null if the photo isn't found
    }

    // Retrieve all photos associated with a property ID
    public List<Photos> getPhotosById(Integer propertyId) {
        return photosRepository.findAllByPropertyId(propertyId); // Assumes you have this method in the repository
    }
}
