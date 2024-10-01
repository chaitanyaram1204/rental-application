package com.RentalApplication.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "properties") // Mapping the class to a table named 'properties'
public class Property implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-incremented primary key
    private Integer id;
    

    @Lob
    private byte[] firstPhoto;

    // Other attributes
    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, length = 50)
    private String category;

    @Column(nullable = false)
    private Float cost;

    @Column(length = 500)
    private String description;

    @Column(nullable = false)
    private Boolean availability;

    @Column(nullable = false, length = 100)
    private String location;

    @Column(nullable = false)
    private Integer capacity;
    
    @ManyToOne
    @JoinColumn(name = "hostId", nullable = false)
    private User host;

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Photos> photos;

    public Property() {}

    public Property(String name, String category, Float cost, String description, Boolean availability, String location, User host, Integer capacity) {
        this.name = name;
        this.category = category;
        this.cost = cost;
        this.description = description;
        this.availability = availability;
        this.location = location;
        this.host = host;
        this.capacity = capacity;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Float getCost() {
        return cost;
    }

    public void setCost(Float cost) {
        this.cost = cost;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getAvailability() {
        return availability;
    }

    public void setAvailability(Boolean availability) {
        this.availability = availability;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public User getHost() {
        return host;
    }

    public void setHost(User host) {
        this.host = host;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public List<Photos> getPhotos() {
        return photos;
    }

    public void setPhotos(List<Photos> photos) {
        this.photos = photos;
    }
    
    
    public byte[] getFirstPhoto() {
        return firstPhoto;
    }

    public void setFirstPhoto(byte[] firstPhoto) {
        this.firstPhoto = firstPhoto;
    }
}
