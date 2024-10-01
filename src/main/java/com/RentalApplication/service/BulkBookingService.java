package com.RentalApplication.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.RentalApplication.model.BulkBooking;
import com.RentalApplication.repository.BulkBookingRepository;

import java.util.List;

@Service
public class BulkBookingService {

    @Autowired
    private BulkBookingRepository bulkBookingRepository;

    public List<BulkBooking> getAllBulkBookings() {
        return bulkBookingRepository.findAll();
    }

    public BulkBooking getBulkBookingById(Integer id) {
        return bulkBookingRepository.findById(id).orElse(null);
    }

    public BulkBooking createBulkBooking(BulkBooking bulkBooking) {
        return bulkBookingRepository.save(bulkBooking);
    }


//    public void deleteBulkBooking(Long id) {
//        bulkBookingRepository.deleteById(id);
//    }
    
    public List<BulkBooking> getBookingsByGuest(Long guestId) {
        return bulkBookingRepository.findByGuestId(guestId);
    }

    public List<BulkBooking> getBookingsByProperty(Long propertyId) {
        return bulkBookingRepository.findByPropertyId(propertyId);
    }
    
    public Integer getLastBookingId() {
        return bulkBookingRepository.findLastBookingId();
    }
    
    public List<Integer> getPropertyIdsForBooking(Integer bookingId) {
        return bulkBookingRepository.findPropertyIdsByBookingId(bookingId);
    }
}