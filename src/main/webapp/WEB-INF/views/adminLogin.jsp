<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Full-height container */
        .container-fluid {
            height: 100vh; /* Full viewport height */
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            background: linear-gradient(to right, #f8f9fa, #e9ecef); /* Gradient background for a modern look */
        }

        .login-form {
            width: 100%;
            max-width: 400px; /* Maximum width of the form */
            padding: 25px;
            background-color: #ffffff; /* White background for the form */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            border: 1px solid #e0e0e0; /* Light border for the form */
        }

        .login-form h2 {
            margin-bottom: 20px;
            color: #343a40; /* Dark gray for the heading */
            font-weight: bold; /* Bold heading */
        }

        .login-form label {
            display: block;
            margin-bottom: 8px;
            color: #495057; /* Slightly darker gray for labels */
            font-weight: 500; /* Medium font weight for labels */
        }

        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%; /* Full width inputs */
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ced4da; /* Light border */
            border-radius: 5px; /* Rounded corners */
            font-size: 16px; /* Larger font size for readability */
        }

        .login-form input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff; /* Bootstrap primary color */
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s; /* Smooth color transition */
        }

        .login-form input[type="submit"]:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }

        .login-form a {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            font-weight: 500; /* Medium font weight */
        }

        .login-form a:hover {
            text-decoration: underline;
            color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <form action="${pageContext.request.contextPath}/api/users/adminLogin" method="post" class="login-form">
            <h2>Admin Login</h2>
            <label for="username">Username:</label>
            <input type="email" id="username" name="username" required><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            
            <input type="submit" value="Login">
            
            <!-- Optionally, provide a link to go back or to a registration page -->
            <p><a href="${pageContext.request.contextPath}/api/users/login">Back to Role Selection</a></p>
        </form>
    </div>
</body>
</html>
