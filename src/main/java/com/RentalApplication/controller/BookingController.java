package com.RentalApplication.controller;

import com.RentalApplication.model.Booking;
import com.RentalApplication.model.Property;
import com.RentalApplication.model.User;
import com.RentalApplication.service.BookingService;
import com.RentalApplication.service.PropertyService;
import com.RentalApplication.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/api/bookings")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private UserService userService;
    
    @Autowired
    private PropertyService propertyService;
    
    @Autowired
    private PropertyController propertyController;
    // Create a new booking
    @PostMapping("/create")
    public String createBooking(
            @RequestParam String propertyId,
            @RequestParam String startDate,
            @RequestParam String endDate,
            HttpServletRequest request,
            Model model) {

        // Convert the date strings to Date objects
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date start, end;
        try {
            start = formatter.parse(startDate);
            end = formatter.parse(endDate);
        } catch (Exception e) {
            return "error"; // Handle parsing error
        }

        // Debugging output to log the incoming parameters
        System.out.println("Incoming propertyId: " + propertyId);

        // Fetch the user and property from their IDs
        Integer userId = userService.getUserIdFromJwt(request);
        Integer propertyid = null;

        try {
            propertyid = Integer.parseInt(propertyId);
        } catch (NumberFormatException e) {
            return "error"; // Handle invalid integer
        }

        User user = userService.getUserById(userId).orElse(null);
        Property property = propertyService.getPropertyById(propertyid).orElse(null);

        if (user == null || property == null) {
            return "error";
        }

        // Calculate the difference in days between start and end dates
        long differenceInMilliSeconds = end.getTime() - start.getTime();
        long differenceInDays = differenceInMilliSeconds / (1000 * 60 * 60 * 24);

        // Determine booking type based on the difference
        String bookingType = (differenceInDays > 20) ? "Monthly Booking" : "Standard Booking";

        // Create a new Booking object
        Booking booking = new Booking(user, property, start, end, bookingType);

        // Save the booking
        Booking savedBooking = bookingService.saveBooking(booking);

        // Optionally, add the saved booking to the model if needed
        model.addAttribute("booking", savedBooking);
        
        return propertyController.getAllProperties(model);
    }


    // Get all bookings
    @GetMapping("/{id}")
    public String getAllBookings(@PathVariable("id") Long id, HttpServletRequest request) {
        request.setAttribute("propertyId", id);
        System.out.println(id);
        return "booking_page";
    }



    // Get booking by ID
//    @GetMapping("/{id}")
//    public ResponseEntity<Booking> getBookingById(@PathVariable Integer id) {
//        Optional<Booking> booking = bookingService.getBookingById(id);
//        return booking.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
//                      .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
//    }

    // Get bookings by user ID
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Booking>> getBookingsByUserId(@PathVariable Integer userId) {
        List<Booking> bookings = bookingService.getBookingsByUserId(userId);
        return new ResponseEntity<>(bookings, HttpStatus.OK);
    }

    // Get bookings by property ID
    @GetMapping("/property/{propertyId}")
    public ResponseEntity<List<Booking>> getBookingsByPropertyId(@PathVariable Integer propertyId) {
        List<Booking> bookings = bookingService.getBookingsByPropertyId(propertyId);
        return new ResponseEntity<>(bookings, HttpStatus.OK);
    }

    // Delete a booking by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBookingById(@PathVariable Integer id) {
        Optional<Booking> booking = bookingService.getBookingById(id);
        if (booking.isPresent()) {
            bookingService.deleteBookingById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
