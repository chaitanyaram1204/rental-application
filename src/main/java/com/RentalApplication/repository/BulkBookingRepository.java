package com.RentalApplication.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.RentalApplication.model.BulkBooking;

import java.util.List;

@Repository
public interface BulkBookingRepository extends JpaRepository<BulkBooking, Integer> {

    List<BulkBooking> findByGuestId(Long guestId);

    @Query("SELECT b FROM BulkBooking b JOIN b.propertyIds p WHERE p = :propertyId")
    List<BulkBooking> findByPropertyId(@Param("propertyId") Long propertyId);
    
    @Query(value = "SELECT MAX(id) FROM bulk_booking", nativeQuery = true)
    Integer findLastBookingId();
    
    @Query(value = "SELECT property_id FROM booked_properties WHERE bulk_booking_id = :bookingId", nativeQuery = true)
    List<Integer> findPropertyIdsByBookingId(@Param("bookingId") Integer bookingId);

}