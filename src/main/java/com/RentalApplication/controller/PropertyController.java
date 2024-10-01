package com.RentalApplication.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.RentalApplication.service.UserService;
import com.RentalApplication.model.Photos;
import com.RentalApplication.model.Property;
import com.RentalApplication.model.PropertyDto;
import com.RentalApplication.model.User;
import com.RentalApplication.service.PhotosService;
import com.RentalApplication.service.PropertyService;
import com.RentalApplication.utility.JwtUtility;

@Controller
@RequestMapping("/api/properties")
public class PropertyController {

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private PhotosService photosService;
    @Autowired
    private JwtUtility jwtUtility;
    
    @Autowired
    private UserService userService; 
    
    @Autowired
    private UserController userController;
    
    @Autowired
    public PropertyController(PropertyService propertyService) {
        this.propertyService = propertyService;
    }
    
    @GetMapping("/create")
    public String createprop() {
    	return "property_form";
    }
    @PostMapping("/create")
    public String createProperty(@RequestParam("name") String name,
            @RequestParam("category") String category,
            @RequestParam("cost") Float cost,
            @RequestParam("description") String description,
            @RequestParam(value = "availability", required = false) Boolean availability,
            @RequestParam("location") String location,
            @RequestParam("capacity") Integer capacity,
            HttpServletRequest request, 
            Model model) {
// Extract the host ID from the JWT token (assuming getUserIdFromJwt handles JWT extraction)
			Integer hostId = userService.getUserIdFromJwt(request);
			
			// Create and populate the Property entity
			Property property = new Property();
			property.setName(name);
			property.setCategory(category);
			property.setCost(cost);
			property.setDescription(description);
			property.setAvailability(availability != null ? availability : false); // Default to false if null
			property.setLocation(location);
			property.setCapacity(capacity);
			
			// Retrieve the host entity by ID and associate it with the property
			User host = userService.getHostById(hostId);
			property.setHost(host); // Assuming the host is properly set
			
			// Save the property
			propertyService.saveProperty(property);
			
			// Redirect to the host dashboard, passing the same request and model
			return userController.showHostDashboard(request, model);
}


    // Get property by ID
    @GetMapping("/{id}")
    public ResponseEntity<Property> getPropertyById(@PathVariable Integer id) {
        Optional<Property> property = propertyService.getPropertyById(id);
        return property.map(ResponseEntity::ok)
                       .orElseGet(() -> ResponseEntity.notFound().build());
    }
    
    @GetMapping("/{id}/photos")
    public String getPropertyDetails(@PathVariable Integer id, Model model) {
        // Fetch property details
        Optional<Property> property = propertyService.getPropertyById(id);
        if (property == null) {
            return "error"; // Return an error page if property not found
        }

        // Fetch associated photos
        List<Photos> photos = photosService.getPhotosById(id);
        
        // Add attributes to the model
        model.addAttribute("property", property.get());
        model.addAttribute("photos", photos);

        return "displayProperty"; // Name of your JSP file for property details
    }
    
    // Get all properties
    @GetMapping("/all")
    public String getAllProperties(Model model) {
        List<Property> properties = propertyService.getAllProperties();
        
        // For each property, fetch the first associated photo
        for (Property property : properties) {
        	System.out.print(property.getName());
            List<Photos> photos = photosService.getPhotosById(property.getId());
            if (!photos.isEmpty()) {
                property.setFirstPhoto(photos.get(0).getImage()); // Assuming Property has a setFirstPhoto method
            }
        }

        model.addAttribute("properties", properties);
        return "roles"; // Name of your JSP file (properties.jsp)
    }



    // Update property
    @PutMapping("/{id}")
    public ResponseEntity<Property> updateProperty(@PathVariable Integer id, @RequestBody Property property) {
        Property updatedProperty = propertyService.updateProperty(id, property);
        if (updatedProperty != null) {
            return ResponseEntity.ok(updatedProperty);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete property
    @PostMapping("/{propertyId}")
    public String deleteProperty(@PathVariable("propertyId") Integer id,HttpServletRequest request, 
            Model model) {
        propertyService.deleteProperty(id);
        return userController.showHostDashboard(request, model);
    }

    // Helper method to extract hostId from request (e.g., from JWT token)
    private Integer extractHostIdFromRequest(HttpServletRequest request) {
        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token != null) {
            // Validate and extract email from the token
            String email = jwtUtility.extractEmail(token);
            if (email != null) {
                // Fetch user ID by email
                return userService.getUserIdByEmail(email);
            }
        }

        return null; // Return null if token is missing or invalid
    }
    
    
    @PostMapping("/search")
    public String searchProperties(
            @RequestParam("field") String field,
            @RequestParam("query") String query,
            Model model) {
        List<Property> filteredProperties = propertyService.searchProperties(field, query);
        for (Property property : filteredProperties) {
        	System.out.print(property.getName());
            List<Photos> photos = photosService.getPhotosById(property.getId());
            if (!photos.isEmpty()) {
                property.setFirstPhoto(photos.get(0).getImage()); // Assuming Property has a setFirstPhoto method
            }
        }

        model.addAttribute("properties", filteredProperties);
        return "roles"; // home.jsp or the page where you display the properties
    }

}


