<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.RentalApplication.model.Property" %>
<%@ page import="java.util.Base64" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Properties</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            padding-top: 20px;
        }
        .property-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center; 
    width: 100%;/* Center items horizontally */
}

.property-card {
    display: flex; 
    flex-direction: column; 
    align-items: center; 
    margin: 20px; 
    transition: transform 0.3s, box-shadow 0.3s;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    background-color: #fff; 
    width: 300%; 
    max-width: 200px; 
    flex-grow: 1; /* Allow cards to grow if more space is available */
    min-width: 270px;
}

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }
        .property-card img {
            height: 225px;
            object-fit: cover;
            width:300px;
        }
        
}
        .bulk-booking-btn {
            margin-right: 20px;
        }
        .bulk-button {
            height: 50px;
        }
        .selected {
            border: 3px solid #28a745; /* Green border for selected cards */
        }
        .bulk-booking-bar {
            background-color: transparent;
            padding: 20px;
            position: fixed;
            top: 60px; 
            z-index: 1000;
            display: flex;
            justify-content: space-between;
        }
        .role-selection-bar {
            background-color: #343a40;
            padding: 15px 30px;
            color: #f8f9fa;
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        .role-selection-bar .btn {
            margin-left: 15px;
            border-radius: 30px;
            font-size: 16px;
            padding: 8px 16px;
            transition: background-color 0.3s, color 0.3s;
        }
        .role-selection-bar .btn-light {
            background-color: #007bff;
            color: #ffffff;
            border: none;
        }
        .role-selection-bar .btn-light:hover {
            background-color: #0056b3;
            color: #e0e0e0;
        }
         .search-bar-container {
            display: flex;
            justify-content: center;
            margin-top: 75px; 
        }

        .page-content {
            padding-top: 80px; /* Space for fixed elements */
        }
        .card-title {
            font-weight: bold;
            font-size: 1.2rem;
            color: #343a40; /* Darker color for titles */
        }
        .card-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #28a745; /* Green for prices */
        }
         .search-bar-container form {
            display: flex;
            align-items: center;
        }
        .search-bar-container select,
        .search-bar-container input {
            margin-right: 10px;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .search-bar-container button {
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .search-bar-container button:hover {
            background-color: #0056b3;
        }
        .alert {
            margin: 20px;
            text-align: center;
        }
        
        .property-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Center items horizontally */
        }
    </style>
    <script>
        function handleRoleSelection(role) {
            var redirectUrl = '';
            if (role === 'admin') {
                redirectUrl = '/api/users/redirectBasedOnRole?role=admin';
            } else if (role === 'guest') {
                redirectUrl = '/api/users/guestLogin';
            } else if (role === 'host') {
                redirectUrl = '/api/users/hostLogin';
            }
            if (redirectUrl) {
                window.location.href = redirectUrl;
            }
        }
        function handleLogout() {
            fetch('/api/users/logout', {
                method: 'POST',
                credentials: 'include' // Include cookies in the request
            })
            .then(response => {
                if (response.ok) {
                    // Redirect to the login page after successful logout
                    window.location.href = '/api/properties/all'; // Adjust the redirect URL as needed
                } else {
                    console.error('Logout failed');
                }
            })
            .catch(error => console.error('Error:', error));
        }

        

        let selectedProperties = [];
        let isBulkBookingActive = false;

        function toggleBulkBooking() {
            const bulkBookingBtn = document.getElementById("bulkBookingBtn");
            isBulkBookingActive = !isBulkBookingActive; 

            if (isBulkBookingActive) {
                bulkBookingBtn.innerText = "Finish";
                enablePropertySelection();
            } else {
                bulkBookingBtn.innerText = "Bulk Bookings";
                showBookingForm();
            }

            updatePropertyLinks();
        }

        function updatePropertyLinks() {
            document.querySelectorAll(".property-card a").forEach(link => {
                if (isBulkBookingActive) {
                    link.removeAttribute("href");
                    link.style.pointerEvents = "none"; 
                    link.style.color = "gray"; 
                } else {
                    const propertyId = link.closest('.property-card').dataset.propertyId;
                    link.setAttribute("href", `/api/properties/${propertyId}/photos`);
                    link.style.pointerEvents = ""; 
                    link.style.color = ""; 
                }
            });
        }

        function enablePropertySelection() {
            document.querySelectorAll(".property-card").forEach(card => {
                card.addEventListener('click', function () {
                    const propertyId = this.dataset.propertyId;
                    if (selectedProperties.includes(propertyId)) {
                        selectedProperties = selectedProperties.filter(id => id !== propertyId);
                        this.classList.remove("selected");
                    } else {
                        selectedProperties.push(propertyId);
                        this.classList.add("selected");
                    }
                });
            });
        }

        function showBookingForm() {
            if (selectedProperties.length === 0) {
                alert("No properties selected for bulk booking.");
                return;
            }

            const startDate = prompt("Enter Start Date (YYYY-MM-DD):");
            const endDate = prompt("Enter End Date (YYYY-MM-DD):");

            if (!startDate || !endDate) {
                alert("Please provide both start and end dates.");
                return;
            }

            const bulkBookingData = {
                propertyIds: selectedProperties,
                startDate: startDate,
                endDate: endDate
            };

            fetch('/api/bulk-bookings', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(bulkBookingData),
            })
            .then(response => response.json())
            .then(data => {
                alert('Bulk Booking created successfully!');
                window.location.href = `/api/bulk-bookings`;
            })
            .catch((error) => {
                console.error('Error:', error);
                alert("An error occurred during the booking process.");
            });
        }
    </script>
</head>
<body>
<%
    // Check if the JWT token cookie exists
    Cookie[] cookies = request.getCookies();
    String jwtToken = null;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                jwtToken = cookie.getValue();
                break;
            }
        }
    }
%>
    <div class="role-selection-bar">
    <% if (jwtToken == null) { %>
        <!-- If token is null, show Admin and Users buttons -->
        <button class="btn btn-light" onclick="handleRoleSelection('admin')">Admin</button>
        <div class="dropdown d-inline">
            <button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Users
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item" href="#" onclick="handleRoleSelection('host')">Host</a>
                <a class="dropdown-item" href="#" onclick="handleRoleSelection('guest')">Guest</a>
            </div>
        </div>
    <% } else { %>
        <!-- If token is present, show Logout button and hide Admin/Users -->
        <button class="btn btn-light" onclick="handleLogout()">Logout</button>
    <% } %>
</div>

   <div class="search-bar-container">
    <form id="searchForm" method="post" action="search">
        <select id="searchField" name="field" required>
            <option value="" disabled selected>Select a field</option> <!-- Disabled default option -->
            <option value="name">Property Name</option>
            <option value="category">Category</option>
            <option value="location">Location</option>
        </select>
        <input type="text" id="searchQuery" name="query" placeholder="Search..." required /> <!-- Required query -->
        <button type="submit">Search</button>
    </form>
    <a href="/api/properties/all">Back to all properties</a>
</div>




    <div class="property-list" id="propertyList">
        <!-- Dynamically generated property cards will go here -->
    </div>
</div>




    <div class="bulk-booking-bar">
        <button class="btn btn-primary bulk-booking-btn bulk-button" id="bulkBookingBtn" onclick="toggleBulkBooking()">Bulk Bookings</button>
    </div>

    <div class="container page-content">
    <h1 class="text-center mb-4">All Properties</h1>
    <div class="property-container">
        <div class="row justify-content-center"> <!-- Added justify-content-center -->
            <% 
                List<Property> properties = (List<Property>) request.getAttribute("properties");
                if (properties != null && !properties.isEmpty()) {
                    for (Property property : properties) {
            %>
            
                <div class="col-md-4 property-card" data-property-id="<%= property.getId() %>">
                    <div class="card">
                        <a href="/api/properties/<%= property.getId() %>/photos" class="card">
                            <div class="card-body text-center">
                                <%
                                    byte[] firstPhoto = property.getFirstPhoto();
                                    String base64Image = (firstPhoto != null) ? Base64.getEncoder().encodeToString(firstPhoto) : "";
                                %>
                                <img src="data:image/jpeg;base64,<%= base64Image %>" class="card-img-top" alt="Property Image">
                                <h5 class="card-title"><%= property.getName() %></h5>
                                <p class="card-price">$<%= property.getCost() %></p>
                            </div>
                        </a>
                    </div>
                </div>
            <% 
                    }
                }
                else { 
            %>
                <div class="alert alert-warning" role="alert">
                    No properties available.
                </div>
            <% 
                } 
            %>
        </div>
    </div>
</div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
