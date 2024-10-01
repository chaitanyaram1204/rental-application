package com.RentalApplication.model;
import jakarta.persistence.*; // For JPA annotations
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "users") 
public class User implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// Unique ID for each user
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) 
    private Integer id;

    // Other attributes
    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(nullable = false, length = 100)
    private String password;

    private String profile;

    @Column(nullable = false, length = 255)
    private String address;

    @Column(nullable = false, length = 50)
    private String role;

    @Column(nullable = false, length = 15)
    private String phoneno;

    @OneToMany(mappedBy = "host")
    private List<Property> properties;
    // Constructors
    public User() {}

    public User(String name, String email, String password, String profile, String address, String role, String phoneno) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.profile = profile;
        this.address = address;
        this.role = role;
        this.phoneno = phoneno;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }
}