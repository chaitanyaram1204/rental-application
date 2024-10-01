<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.RentalApplication.model.Property" %>
<%@ page import="com.RentalApplication.model.Photos" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Montserrat', sans-serif;
            color: #333;
        }

        h1, h2 {
            color: #34495e;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 40px;
        }

        .main-photo {
            width: 99%;
            height: 300px; /* Reduced size */
            object-fit: cover;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }
		.move-to-left {
            display: flex;
            justify-content: flex-end; 
            margin-bottom: 20px; 
        }
        .photo-grid img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            margin-bottom: 20px;
            border-radius: 10px;
            transition: transform 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
        }

        .photo-grid img:hover {
            transform: scale(1.08);
        }

        .price-section {
		    background-color: #fff;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    display: flex; /* Use Flexbox */
		    flex-direction: column; 
		    justify-content: center; 
		    align-items: center; 
		    text-align: center; 
		}


		.btn-size{
			width:50%;
		}


        .property-details {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            margin-top: 40px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.05);
        }
        .move-to-left {
            display: flex;
            justify-content: flex-start; /* Aligns the button to the left */
            margin-bottom: 20px; 
        }

        .property-details p {
            font-size: 16px;
            color: #2c3e50;
            margin-bottom: 12px;
        }

        .property-details p strong {
            color: #2980b9;
        }

        .row {
            margin: 0;
        }

        .row > .col-md-7, .row > .col-md-5 {
            padding: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Property Name -->
        <div class="move-to-left">
        <a href="/api/properties/all" class="btn btn-primary btn-home">
            <i class="fas fa-home"></i> Home
        </a>
        
    </div>
        <h1><%= ((Property) request.getAttribute("property")).getName() %></h1>

        <!-- Main Photo and Price Section -->
        <div class="row">
            <div class="col-md-7">
                <%
                    List<Photos> photos = (List<Photos>) request.getAttribute("photos");
                    if (photos != null && !photos.isEmpty()) {
                        Photos firstPhoto = photos.get(0);
                        byte[] firstPhotoImage = firstPhoto.getImage();
                        String firstPhotoBase64 = (firstPhotoImage != null) ? Base64.getEncoder().encodeToString(firstPhotoImage) : "";
                %>
                <img src="data:image/jpeg;base64,<%= firstPhotoBase64 %>" class="main-photo" alt="Property Main Image">
                <%
                    } else {
                %>
                <p>No main image available.</p>
                <%
                    }
                %>
            </div>

           <!-- Price Section -->
			<div class="col-md-5 price-section">
			    <h2>₹<%= ((Property) request.getAttribute("property")).getCost() %> / night</h2>
			    <p><strong>2-bedroom unit featuring a double bed in each room and en-suite private washrooms.</strong></p>
			    <a href="/api/bookings/<%= ((Property) request.getAttribute("property")).getId() %>" class="btn btn-primary btn-block btn-size">Book Now</a>
			</div>

        </div>

        <!-- Additional Photos Section -->
        <div class="row mt-4">
            <h2>Photos</h2>
            <div class="row">
                <%
                    if (photos != null && photos.size() > 1) {
                        List<Photos> remainingPhotos = photos.subList(1, photos.size());
                        for (Photos photo : remainingPhotos) {
                            byte[] photoImage = photo.getImage();
                            String photoBase64 = (photoImage != null) ? Base64.getEncoder().encodeToString(photoImage) : "";
                %>
                <div class="col-md-3 photo-grid">
                    <img src="data:image/jpeg;base64,<%= photoBase64 %>" alt="Property Photo">
                </div>
                <%
                        }
                    } else {
                %>
                <div class="col-12">
                    <p>No additional photos available.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Property Details Section -->
        <div class="property-details">
            <h2>Details</h2>
            <p><strong>Category:</strong> <%= ((Property) request.getAttribute("property")).getCategory() %></p>
            <p><strong>Description:</strong> <%= ((Property) request.getAttribute("property")).getDescription() %></p>
            <p><strong>Location:</strong> <%= ((Property) request.getAttribute("property")).getLocation() %></p>
            <p><strong>Capacity:</strong> <%= ((Property) request.getAttribute("property")).getCapacity() %></p>
            <p><strong>Availability:</strong> <%= ((Property) request.getAttribute("property")).getAvailability() ? "Available" : "Not Available" %></p>
            <p><strong>Host:</strong> <%= ((Property) request.getAttribute("property")).getHost() != null ? ((Property) request.getAttribute("property")).getHost().getName() : "N/A" %></p>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
 	