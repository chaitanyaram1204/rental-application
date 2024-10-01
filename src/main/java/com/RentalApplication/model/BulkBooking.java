package com.RentalApplication.model;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "bulk_booking")
public class BulkBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "guest_id", referencedColumnName = "id")
    private User guest;

    @ElementCollection
    @CollectionTable(name = "booked_properties", joinColumns = @JoinColumn(name = "bulk_booking_id"))
    @Column(name = "property_id")
    private List<Integer> propertyIds;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    // Constructors, Getters, and Setters
    public BulkBooking() {}

    public BulkBooking(User guest, List<Integer> propertyIds, Date startDate, Date endDate) {
        this.guest = guest;
        this.propertyIds = propertyIds;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public User getGuest() {
        return guest;
    }

    public void setGuest(User guest) {
        this.guest = guest;
    }

    public List<Integer> getPropertyIds() {
        return propertyIds;
    }

    public void setPropertyIds(List<Integer> propertyIds) {
        this.propertyIds = propertyIds;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}