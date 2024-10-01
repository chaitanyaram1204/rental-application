package com.RentalApplication.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.RentalApplication.model.BulkBooking;
import com.RentalApplication.model.Photos;
import com.RentalApplication.model.Property;
import com.RentalApplication.service.BulkBookingService;
import com.RentalApplication.service.PhotosService;
import com.RentalApplication.service.PropertyService;

import jakarta.servlet.http.HttpServletRequest;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/api/bulk-bookings")
public class BulkBookingController {

    @Autowired
    private BulkBookingService bulkBookingService;
    
    @Autowired
    private PhotosService photosService;
    
    @Autowired
    private PropertyService propertyService;

    @GetMapping
    public String getAllBulkBookings(HttpServletRequest request, Model model) {
        
        Integer lastBookingId = bulkBookingService.getLastBookingId();
        System.out.print(lastBookingId);
        BulkBooking curr = bulkBookingService.getBulkBookingById(lastBookingId);
        List<Integer> propertyIds = bulkBookingService.getPropertyIdsForBooking(lastBookingId);
        for (Integer id : propertyIds) {
            System.out.println(id);
        }
        List<Property> properties = new ArrayList<>();
        
        for (Integer id : propertyIds) {
            Optional<Property> propertys = propertyService.getPropertyById(id);
            Property property = propertys.get();// Ensure this method exists and works correctly
            if (property != null) { 
                properties.add(property);
                
                List<Photos> photos = photosService.getPhotosById(property.getId());
                if (!photos.isEmpty()) {
                    property.setFirstPhoto(photos.get(0).getImage()); // Assuming Property has a setFirstPhoto method
                }
            }
        }
        int count = properties.size();
        model.addAttribute("properties", properties);
        model.addAttribute("bookingId",curr.getId());
        model.addAttribute("startDate", formatDate(curr.getStartDate()));
        model.addAttribute("endDate", formatDate(curr.getEndDate()));
        model.addAttribute("propertyCount", count);

        return "bulkBookingDisplay";
    }

    public static String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Customize the format as needed
        return sdf.format(date);
    }
    @GetMapping("/{id}")
    public ResponseEntity<BulkBooking> getBulkBookingById(@PathVariable Integer id) {
        BulkBooking bulkBooking = bulkBookingService.getBulkBookingById(id);
        return bulkBooking != null ? ResponseEntity.ok(bulkBooking) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public BulkBooking createBulkBooking(@RequestBody BulkBooking bulkBooking) {
        return bulkBookingService.createBulkBooking(bulkBooking);
    }

//    @PutMapping("/{id}")
//    public ResponseEntity<BulkBooking> updateBulkBooking(@PathVariable Long id, @RequestBody BulkBooking bulkBooking) {
//        BulkBooking updatedBulkBooking = bulkBookingService.updateBulkBooking(id, bulkBooking);
//        return updatedBulkBooking != null ? ResponseEntity.ok(updatedBulkBooking) : ResponseEntity.notFound().build();
//    }
//
//    @DeleteMapping("/{id}")
//    public ResponseEntity<Void> deleteBulkBooking(@PathVariable Long id) {
//        bulkBookingService.deleteBulkBooking(id);
//        return ResponseEntity.noContent().build();
//    }
    
    
    @GetMapping("/guest/{guestId}")
    public ResponseEntity<List<BulkBooking>> getBookingsByGuest(@PathVariable Long guestId) {
        List<BulkBooking> bookings = bulkBookingService.getBookingsByGuest(guestId);
        return bookings != null && !bookings.isEmpty() ? ResponseEntity.ok(bookings) : ResponseEntity.notFound().build();
    }

    // Fetch bookings by property ID
    @GetMapping("/property/{propertyId}")
    public ResponseEntity<List<BulkBooking>> getBookingsByProperty(@PathVariable Long propertyId) {
        List<BulkBooking> bookings = bulkBookingService.getBookingsByProperty(propertyId);
        return bookings != null && !bookings.isEmpty() ? ResponseEntity.ok(bookings) : ResponseEntity.notFound().build();
    }
}