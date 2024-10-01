<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.RentalApplication.model.Property" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Properties</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            padding-top: 20px;
        }
        .property-card {
            margin: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>All Properties</h1>
        <div class="row">
            <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            if (properties != null) {
                for (Property property : properties) {
            %>
                <div class="col-md-4 property-card">
                    <a href="<%= request.getContextPath() %>/properties/<%= property.getId() %>/photos" class="card">
                        <%
                            byte[] firstPhoto = property.getFirstPhoto();
                            String base64Image = (firstPhoto != null) ? Base64.getEncoder().encodeToString(firstPhoto) : "";
                        %>
                        <img src="data:image/jpeg;base64,<%= base64Image %>" 
                             class="card-img-top" 
                             alt="Property Image">
                        <div class="card-body">
                            <h5 class="card-title"><%= property.getName() %></h5>
                            <p class="card-text">$<%= property.getCost() %></p>
                        </div>
                    </a>
                </div>
            <%
                }
            } else {
            %>
                <div class="alert alert-warning" role="alert">
                    No properties available.
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
