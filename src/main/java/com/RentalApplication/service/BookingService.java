package com.RentalApplication.service;

import com.RentalApplication.model.Booking;
import com.RentalApplication.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    // Save a new booking
    public Booking saveBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    // Get all bookings
    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    // Get a booking by ID
    public Optional<Booking> getBookingById(Integer id) {
        return bookingRepository.findById(id);
    }

    // Get bookings by user ID
    public List<Booking> getBookingsByUserId(Integer userId) {
        return bookingRepository.findByUserId(userId);
    }

    // Get bookings by property ID
    public List<Booking> getBookingsByPropertyId(Integer propertyId) {
        return bookingRepository.findByPropertyId(propertyId);
    }

    // Delete a booking by ID
    public void deleteBookingById(Integer id) {
        bookingRepository.deleteById(id);
    }
}
