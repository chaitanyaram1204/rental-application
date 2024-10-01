<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.RentalApplication.model.Photos" %>
<%@ page import="java.util.Base64" %>
<html>
<head>
    <title>Property Photos</title>
    <style>
        .photo-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .photo {
            border: 1px solid #ccc;
            padding: 5px;
            width: 150px; /* Adjust width as needed */
        }
        img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <h1>Photos for Property ID: <%= request.getAttribute("propertyId") %></h1>
    <div class="photo-container">
        <%
            List<Photos> photos = (List<Photos>) request.getAttribute("photos");
            if (photos != null && !photos.isEmpty()) {
                for (Photos photo : photos) {
                    byte[] imageBytes = photo.getImage();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        %>
                    <div class="photo">
                        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Property Photo" />
                    </div>
        <%
                }
            } else {
        %>
                <p>No photos available for this property.</p>
        <%
            }
        %>
        <a href="/api/users/host-dashboard">Back to dashboard</a>
    </div>
</body>
</html>
