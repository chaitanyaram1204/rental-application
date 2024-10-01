package com.RentalApplication.controller;

import com.RentalApplication.model.Photos;
import com.RentalApplication.model.Property;
import com.RentalApplication.service.PhotosService;
import com.RentalApplication.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/photos")
public class PhotosController {

    @Autowired
    private PhotosService photosService;

    @Autowired
    private PropertyService propertyService;

    // Render the upload form
    @GetMapping("/uploads")
    public String uploadImages(@RequestParam("propertyId") Integer propertyId, org.springframework.ui.Model model) {
        // Pass the propertyId to the form to dynamically use it
        model.addAttribute("propertyId", propertyId);
        return "upload-images"; // JSP or HTML view for uploading images
    }

    // Handle photo upload
    @PostMapping("/upload/{propertyId}")
    public String uploadPhoto(@PathVariable("propertyId") Integer propertyId, @RequestParam("file") MultipartFile file) {
        try {
            Optional<Property> property = propertyService.getPropertyById(propertyId);
            if (!property.isPresent()) {
                return "redirect:/error"; // Handle error when property not found
            }
            photosService.savePhoto(file, propertyId, property); // Save the photo with the property
            return "upload-images"; // Redirect to the success page
        } catch (IOException e) {
            return "redirect:/error"; // Handle error during upload
        }
    }

    // Serve the uploaded photo by ID
    @GetMapping("/{id}")
    public ResponseEntity<List<byte[]>> getPhotos(@PathVariable Integer id) {
        List<Photos> photos = photosService.getPhotosById(id); // Assuming this method returns a list of Photos
        if (photos == null || photos.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        
        List<byte[]> images = photos.stream()
                                     .map(Photos::getImage)
                                     .collect(Collectors.toList());
        
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, "application/json") // Set to JSON since we're returning a list
                .body(images);
    }
    
    @GetMapping("/{id}/photos")
    public String getPhotos(@PathVariable Integer id, Model model) {
        // Retrieve the property by its ID
        Optional<Property> property = propertyService.getPropertyById(id);
        
        if (property != null) {
            // Fetch the photos associated with this property
            List<Photos> photos = photosService.getPhotosById(id); // Assuming this method retrieves photos linked to the property ID
            
            model.addAttribute("propertyId",id);
            model.addAttribute("property", property); // Pass the property for additional details if needed
            model.addAttribute("photos", photos); // Pass the list of photos
            return "propertyPhotos"; // Name of your JSP file (propertyPhotos.jsp)
        } else {
            model.addAttribute("error", "Property not found.");
            return "error"; // Redirect to an error page or handle accordingly
        }
    }




}