package com.RentalApplication.controller;

import com.RentalApplication.model.Photos;
import com.RentalApplication.model.Property;
import com.RentalApplication.model.User;
import com.RentalApplication.service.PhotosService;
import com.RentalApplication.service.PropertyService;
import com.RentalApplication.service.UserService;
import com.RentalApplication.utility.JwtUtility;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.net.URI;
import java.util.List;
import java.util.Optional;
@Controller
@RequestMapping("/api/users")
public class UserController {
	private static final String SecurityContextHolder = null;

    @Autowired
    private UserService userService;
    
    @Autowired
    private PropertyService propertyService;
    
    @Autowired
    private PhotosService photosService;
    
  
    
    public UserController(UserService userService) {
        this.userService = userService;
    }


    @Autowired
    private JwtUtility jwtUtility;

    // Get all users
    @GetMapping("/all")
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    // Get a user by ID
    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Integer id) {
        Optional<User> userOptional = userService.getUserById(id);
        if (userOptional.isPresent()) {
            return new ResponseEntity<>(userOptional.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @GetMapping("/guestSignup")
    public String showGuestSignupPage() {
        return "guestSignup"; // Ensure guestSignup.jsp or guestSignup.html exists
    }
    @GetMapping("/guestLogin")
    public String showGuestLoginPage() {
        return "guestLogin"; // Ensure guestSignup.jsp or guestSignup.html exists
    }
    @GetMapping("/hostSignup")
    public String showHostSignupPage() {
        return "hostSignup"; // Ensure guestSignup.jsp or guestSignup.html exists
    }
    @GetMapping("/hostLogin")
    public String showHostLoginPage() {
        return "hostLogin"; // Ensure guestSignup.jsp or guestSignup.html exists
    }
    // Create a new user
    @PostMapping("/create")
    public ResponseEntity<User> createUser(@RequestBody User user) {
        User savedUser = userService.saveUser(user);
        return new ResponseEntity<>(savedUser, HttpStatus.CREATED);
    }

    // Update an existing user
    @PutMapping("/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Integer id, @RequestBody User userDetails) {
        Optional<User> userOptional = userService.getUserById(id);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setName(userDetails.getName());
            user.setEmail(userDetails.getEmail());
            user.setPassword(userDetails.getPassword());
            user.setProfile(userDetails.getProfile());
            user.setAddress(userDetails.getAddress());
            user.setRole(userDetails.getRole());
            user.setPhoneno(userDetails.getPhoneno());

            User updatedUser = userService.updateUser(user);
            return new ResponseEntity<>(updatedUser, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a user
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Integer id) {
        Optional<User> userOptional = userService.getUserById(id);
        if (userOptional.isPresent()) {
            userService.deleteUser(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Admin Login Handler with JWT Token
    @PostMapping("/adminLogin")
    public ModelAndView adminLogin(@RequestParam("username") String username, 
                                   @RequestParam("password") String password, 
                                   HttpSession session, Model model) {
        ModelAndView modelAndView = new ModelAndView();
        
        // Authenticate admin by checking the username and password
        boolean isAuthenticated = userService.authenticateAdmin(username, password);
        
        // Check if the user is an admin in the database
        if (isAuthenticated) {
            // Store the admin's email in the session
            session.setAttribute("loggedInAdmin", username);
            
            // Set the view to redirect to the admin dashboard
            modelAndView.setViewName("redirect:/admin/dashboard");
        } else {
            // If authentication fails, set an error message
            model.addAttribute("error", "Invalid username or password.");
            modelAndView.setViewName("admin/login");
        }
        
        return modelAndView;
    }




    // Host Login Handler with JWT Token
   /* @PostMapping("/hostLogin")
    public String hostLogin(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpServletResponse response) {
        boolean isAuthenticated = userService.authenticateUser(email, password, "host");

        if (isAuthenticated) {
            // Generate JWT token for the host
            String token = jwtUtility.generateToken(email);

            // Create a cookie to store the JWT token
            Cookie jwtCookie = new Cookie("token", token);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setSecure(true);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(60 * 60 * 24);

            // Add the cookie to the response
            response.addCookie(jwtCookie);

            return "roles"; // Redirect to roles page or wherever necessary
        } else {
            return "Invalid email or password.";
        }
    }*/
    @PostMapping("/hostLogin")
    public String hostLogin(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpServletResponse response,
                            HttpServletRequest request,Model model) {
        boolean isAuthenticated = userService.authenticateUser(email, password, "host");

        if (isAuthenticated) {
            // Generate JWT token for the host
            String token = jwtUtility.generateToken(email);

            // Create a cookie to store the JWT token
            Cookie jwtCookie = new Cookie("token", token);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setSecure(true);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(jwtCookie);
            String jwtToken = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("token".equals(cookie.getName())) {
                        jwtToken = cookie.getValue();
                        break;
                    }
                }
            }

            // Validate the JWT token and extract the host email
            try {
                String hostEmail = jwtUtility.extractEmail(jwtToken);
                System.out.println("Extracted Email: " + hostEmail);
            } catch (Exception e) {
                System.out.println("Error extracting email from token: " + e.getMessage());
            }
            // Retrieve the host's user ID from their email
            Integer hostId = userService.getUserIdFromJwt(request);
            List<Property> properties = null;

            try {
                // Call the method on the userService instance
                properties = userService.getPropertiesByHostId(hostId);
            } catch (Exception e) {
                e.printStackTrace(); // Handle the exception appropriately
            }
            for (Property property : properties) {
                System.out.println("Property Name: " + property.getName());
                System.out.println("Property Address: " + property.getLocation());
            }

            model.addAttribute("properties", properties);
            return "host-dashboard";
            
        } else {
            model.addAttribute("errorMessage", "Invalid email or password. Please try again.");

            return "hostLogin";
        }
    }

    @GetMapping("/host-dashboard")
    public String showHostDashboard(HttpServletRequest request, Model model) {
        // Extract the JWT token from cookies
        String jwtToken = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    jwtToken = cookie.getValue();
                    break;
                }
            }
        }

        // Validate the JWT token and extract the host email
        try {
            String hostEmail = jwtUtility.extractEmail(jwtToken);
            System.out.println("Extracted Email: " + hostEmail);
        } catch (Exception e) {
            System.out.println("Error extracting email from token: " + e.getMessage());
        }

        // Retrieve the host's user ID from their email
        Integer hostId = userService.getUserIdFromJwt(request);
        List<Property> properties = null;

        try {
            // Call the method on the userService instance to fetch properties
            properties = userService.getPropertiesByHostId(hostId);
        } catch (Exception e) {
            e.printStackTrace(); // Handle the exception appropriately
        }

        for (Property property : properties) {
            System.out.println("Property Name: " + property.getName());
            System.out.println("Property Address: " + property.getLocation());
        }

        // Add the list of properties to the model
        model.addAttribute("properties", properties);
        return "host-dashboard";
    }



    // Guest Login Handler with JWT Token
    @PostMapping("/guestLogin")
    public String guestLogin(@RequestParam("email") String email,
                             @RequestParam("password") String password,
                             HttpServletResponse response,Model model) {
        boolean isAuthenticated = userService.authenticateUser(email, password, "guest");


        if (isAuthenticated) {
            // Generate JWT token for the host
            String token = jwtUtility.generateToken(email);

            // Create a cookie to store the JWT token
            Cookie jwtCookie = new Cookie("token", token);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setSecure(true);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(jwtCookie);
           
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
            return "roles"; 
        } else {
            model.addAttribute("errorMessage", "Invalid email or password. Please try again.");
            return "guestLogin";
        }
    }


    // Host Signup Handler
    @PostMapping("/hostSignup")
    public ResponseEntity<?> hostSignup(@RequestParam("name") String name,
                                        @RequestParam("email") String email,
                                        @RequestParam("password") String password,
                                        @RequestParam("profile") String profile,
                                        @RequestParam("address") String address,
                                        @RequestParam("phoneno") String phoneno) {
        User user = new User(name, email, password, profile, address, "host", phoneno);
        userService.saveUser(user);

        return new ResponseEntity<>("Host registration successful.", HttpStatus.CREATED);
    }

    // Guest Signup Handler
    @PostMapping("/guestSignup")
    public ResponseEntity<?> guestSignup(@RequestParam("name") String name,
                                         @RequestParam("email") String email,
                                         @RequestParam("password") String password,
                                         @RequestParam("profile") String profile,
                                         @RequestParam("address") String address,
                                         @RequestParam("phoneno") String phoneno) {
        User user = new User(name, email, password, profile, address, "guest", phoneno);
        userService.saveUser(user);

        return new ResponseEntity<>("Guest registration successful.", HttpStatus.CREATED);
    }
    @GetMapping("/login")
    public String getPages() {
    	System.out.print("hello");
        return "roles"; // Ensure roles.jsp or roles.html exists
    }

    @GetMapping("/temp")
    public String getguysPages() {
    	System.out.print("hello");
        return "roles"; // Ensure roles.jsp or roles.html exists
    }
    
 
        @GetMapping("/property-form")
        public String showPropertyForm() {
            return "property_form"; // This will resolve to /WEB-INF/views/property_form.jsp
        }
        @PostMapping("/logout")
        public String logout(HttpServletRequest request, HttpServletResponse response,Model model) {
            // Invalidate the JWT token stored in the cookie
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("token".equals(cookie.getName())) {
                        cookie.setValue(null); // Clear the token
                        cookie.setMaxAge(0);   // Set expiry to 0
                        cookie.setPath("/");    // Make sure to clear the cookie path
                        response.addCookie(cookie);
                    }
                }
            }
            request.getSession().invalidate();

            // Redirect to the login page
            return "roles";
        }
    


    // Redirect based on the selected role
    @GetMapping("/redirectBasedOnRole")
    public ModelAndView redirectBasedOnRole(
            @RequestParam("role") String role,
            @RequestParam(value = "userRole", required = false) String userRole,
            HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView();
     //HttpServletRequest request = null;
		// Fetch user ID from JWT token
        Integer userId = userService.getUserIdFromJwt(request);
        System.out.println("Extracted User ID: " + userId);
        
        if (userId != null) {
            Optional<User> userOptional = userService.getUserById(userId);
            if (userOptional.isPresent()) {
                User user = userOptional.get();

        if ("admin".equalsIgnoreCase(role)) {
            modelAndView.setViewName("adminLogin"); // Redirect to admin login page
        } else if ("users".equalsIgnoreCase(role)) {
            if ("guest".equalsIgnoreCase(userRole)) {
                modelAndView.setViewName("guestLogin"); // Redirect to guest login page
            } else if ("host".equalsIgnoreCase(userRole)) {
                modelAndView.setViewName("hostLogin"); // Redirect to host login page
            } else {
                modelAndView.setViewName("errorPage"); // Redirect to an error page for invalid user role
                modelAndView.addObject("error", "Invalid user role.");
            }
        } else {
            modelAndView.setViewName("errorPage"); // Redirect to an error page for invalid role
            modelAndView.addObject("error", "Invalid role.");
        }
            } 
        }

        return modelAndView;
    }
}
