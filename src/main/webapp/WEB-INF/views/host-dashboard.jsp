<%@ page import="java.util.List" %>
<%@ page import="com.RentalApplication.model.Property" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>Host Dashboard</title>
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
        }
        .btn-home {
        margin-top: 30px;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-home:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
        h1 {
            margin-top: -30px;
            color: #007bff;
             text-align: left;
        }
        h2 {
    text-align: center;  /* This line centers the text */
    color: #333;
    margin-top: 20px;  /* This provides some spacing above the heading */
}
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #dee2e6;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        .no-properties {
            text-align: center;
            color: #dc3545;
            font-weight: bold;
        }
        .alert {
            margin-top: 20px;
        }
        .add-property-btn {
            margin-top: 90px; /* Adjust this value to increase/decrease the space */
        }
    </style>
    <script>
    function deleteProperty(propertyId) {
        if (confirm('Are you sure you want to delete this property?')) {
            fetch(`/api/properties/${propertyId}`, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    location.reload(); // Reloads the page to reflect changes
                } else {
                    alert('Failed to delete property.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while deleting the property.');
            });
        }
    }
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6">
            <a href="/api/properties/all" class="btn btn-primary btn-home">
                <i class="fas fa-home"></i> Home
            </a>
        </div>
        <div class="col-md-6 text-right">
        <div class="add-property-btn mb-3">
            <a href="/api/properties/create" class="btn btn-success mb-3">Add Property</a>
        </div>
    </div>

    <h1>Welcome, Host!</h1>
    

    <h2>Your Properties</h2>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Property Name</th>
                <th>Location</th>
                <th>Available</th>
                <th>Upload Photo</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Property> properties = (List<Property>) request.getAttribute("properties");

            if (properties != null && !properties.isEmpty()) {
                for (Property property : properties) {
        %>
                    <tr>
                        <td><%= property.getName() %></td>
                        <td><%= property.getLocation() %></td>
                        <td><%= property.getAvailability() ? "Yes" : "No" %></td>
                        <td>
                            <a href="/photos/uploads?propertyId=<%= property.getId() %>" class="btn btn-warning btn-sm">Upload Photo</a>
                        </td>
                        <td>
                            <form action="/api/properties/<%= property.getId() %>" method="post" onsubmit="return confirm('Are you sure you want to delete this property?');">
                                <input type="hidden" name="_method" value="DELETE">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash-alt"></i> Delete Property
                                </button>
                            </form>
                        </td>
                    </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5" class="no-properties">No properties available</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
