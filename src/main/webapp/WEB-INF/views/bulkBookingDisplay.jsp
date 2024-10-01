<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.RentalApplication.model.Property" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bulk Booking Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            padding-top: 20px;
        }
        .property-card {
            margin: 15px;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }
        .property-card img {
            height: 200px;
            object-fit: cover;
        }
        .bulk-booking-info {
            margin-bottom: 30px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .move-to-left {
            margin-bottom: 20px; 
            text-align: right;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="move-to-left">
            <a href="/api/properties/all" class="btn btn-primary">
                <i class="fas fa-home"></i> Home
            </a>
        </div>
    <div class="bulk-booking-info">
        <h1 class="text-center">Bulk Booking Details</h1>
        <p><strong>Booking ID:</strong> <%= request.getAttribute("bookingId") %></p>
        <p><strong>Start Date:</strong> <%= request.getAttribute("startDate") %></p>
        <p><strong>End Date:</strong> <%= request.getAttribute("endDate") %></p>
        <p><strong>Number of Properties Booked:</strong> <%= request.getAttribute("propertyCount") %></p>
    </div>

    <div class="row justify-content-center">
        <% 
            List<Property> bookedProperties = (List<Property>) request.getAttribute("properties");
            if (bookedProperties != null && !bookedProperties.isEmpty()) {
                for (Property property : bookedProperties) {
        %>
            <div class="col-md-4 col-sm-6 property-card">
                <div class="card">
                    <div class="card-body text-center">
                        <%
                            byte[] firstPhoto = property.getFirstPhoto();
                            String base64Image = (firstPhoto != null) ? Base64.getEncoder().encodeToString(firstPhoto) : "";
                        %>
                        <img src="data:image/jpeg;base64,<%= base64Image %>" class="card-img-top" alt="Property Image">
                        <h5 class="card-title"><%= property.getName() %></h5>
                        <p class="card-price">$<%= property.getCost() %></p>
                    </div>
                </div>
            </div>
        <% 
                }
            } else { 
        %>
            <div class="col-12">
                <div class="alert alert-warning text-center" role="alert">
                    No properties found for this booking.
                </div>
            </div>
        <% 
            } 
        %>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
