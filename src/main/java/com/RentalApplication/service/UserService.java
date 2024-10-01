package com.RentalApplication.service;

import com.RentalApplication.model.Property;
import com.RentalApplication.model.User;
import com.RentalApplication.repository.PropertyRepository;
import com.RentalApplication.repository.UserRepository;
import com.RentalApplication.utility.JwtUtility;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.http.HttpServletRequest;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtility jwtUtility;
    @Autowired
    private PropertyRepository propertyRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public User getHostById(Integer hostId) {
        // Use JPQL query to fetch the host by ID
        return entityManager.createQuery("SELECT h FROM User h WHERE h.id = :hostId", User.class)
                            .setParameter("hostId", hostId)
                            .getSingleResult();
    }
    // Load user by username (email)
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                                  .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + email));
        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPassword())
                .roles(user.getRole())  // Ensure roles are properly assigned
                .build();
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(Integer id) {
        return userRepository.findById(id);
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public User updateUser(User user) {
        return userRepository.save(user);
    }

    public void deleteUser(Integer id) {
        userRepository.deleteById(id);
    }
    public List<Property> getPropertiesByHostId(Integer hostId) {
        return propertyRepository.findByHostId(hostId);
    }

    // Admin Authentication
    public boolean authenticateAdmin(String username, String password) {
        Optional<User> userOptional = userRepository.findByEmail(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return "admin".equalsIgnoreCase(user.getRole()) && password.equals(user.getPassword());
        }
        return false;
    }

    // Guest Authentication
    public boolean authenticateUser(String email, String password, String role) {
        Optional<User> userOptional = userRepository.findByEmail(email);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return role.equalsIgnoreCase(user.getRole()) && password.equals(user.getPassword());
        }
        return false;
    }

    // Host Authentication
    public boolean authenticateHost(String email, String password) {
        Optional<User> userOptional = userRepository.findByEmail(email);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return "host".equalsIgnoreCase(user.getRole()) && password.equals(user.getPassword());
        }
        return false;
    }

    // Method to get user ID from JWT token
    public Integer getUserIdFromJwt(HttpServletRequest request) {
        String token = getJwtFromCookie(request);
            String email = jwtUtility.extractEmail(token);
            Optional<User> userOptional = getUserByEmail(email);
            if (userOptional.isPresent()) {
                return userOptional.get().getId();
            }
    
        return null; // or handle as appropriate if user ID not found
    }

    // Utility method to fetch JWT from cookies
    public String getJwtFromCookie(HttpServletRequest request) {
        if (request == null) {
            return null; // or throw an appropriate exception
        }
        jakarta.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (jakarta.servlet.http.Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    public Integer getUserIdByEmail(String email) {
        Optional<User> userOptional = getUserByEmail(email);
        return userOptional.map(User::getId).orElse(null);
    }

}
