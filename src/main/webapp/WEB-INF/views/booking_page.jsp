<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Optional" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Montserrat', sans-serif;
            color: #333;
        }
        .container {
            margin-top: 50px;
            max-width: 600px; /* Increased container width for better spacing */
            padding: 20px;
            background-color: #ffffff; /* White background for the form */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        h2 {
            color: #007bff; /* Heading color */
        }
        .form-group label {
            font-weight: bold; /* Bold labels */
        }
        .form-control {
            height: 40px; /* Increased height for better usability */
            border-radius: 5px; /* Rounded corners for input fields */
            border: 1px solid #ced4da; /* Default border color */
            transition: border-color 0.3s; /* Smooth transition for focus */
        }
        .form-control:focus {
            border-color: #007bff; /* Border color on focus */
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Light blue shadow */
        }
        .btn {
            height: 40px; /* Match button height with input fields */
            background-color: #007bff; /* Primary button color */
            border: none; /* Remove border */
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s, transform 0.2s; /* Smooth transitions */
        }
        .btn:hover {
            background-color: #0056b3; /* Darker shade on hover */
            transform: scale(1.05); /* Slightly enlarge button on hover */
        }
        .toast {
            position: fixed;
            bottom: 20px; /* Position at the bottom */
            left: 50%; /* Center horizontally */
            transform: translateX(-50%); /* Adjust to center */
            z-index: 1050;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4">Book Property</h2>

        <form id="bookingForm" action="/api/bookings/create" method="POST">
            <input type="hidden" name="propertyId" value="<%= request.getAttribute("propertyId") %>">

            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <input type="text" class="form-control" id="startDate" name="startDate" required>
            </div>

            <div class="form-group">
                <label for="endDate">End Date:</label>
                <input type="text" class="form-control" id="endDate" name="endDate" required>
            </div>

            <button type="submit" class="btn btn-primary btn-block">Confirm Booking</button>
        </form>

        <div class="toast" id="bookingToast" data-autohide="true" data-delay="10000" aria-live="assertive" aria-atomic="true"> <!-- Set data-delay to 10000 milliseconds (10 seconds) -->
    <div class="toast-header">
        <strong class="mr-auto">🎉 Booking Status 🎉</strong>
        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="toast-body">
        Your booking was successful! 🥳
    </div>
</div>

    <script>
        flatpickr("#startDate", {
            minDate: "today",
            dateFormat: "Y-m-d",
        });

        flatpickr("#endDate", {
            minDate: "today",
            dateFormat: "Y-m-d",
        });

        $("#bookingForm").on("submit", function(event) {
            event.preventDefault(); // Prevent the default form submission
            $('#bookingToast').toast('show'); // Show the toast

            // Wait for the toast to be displayed before submitting the form
            setTimeout(() => {
                // Submit the form normally
                this.submit();
            }, 500); // Adjust this duration as needed
        });
    </script>
</body>
</html>
