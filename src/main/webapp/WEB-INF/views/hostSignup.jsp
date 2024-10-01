<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Host Signup</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f4ff; /* Light blue background */
        }
        .container {
            max-width: 450px;
            margin-top: 50px;
            padding: 30px;
            border-radius: 10px;
            background-color: #ffffff; /* White background for the form */
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.5s ease-in-out;
        }
        h2 {
            color: #007bff; /* Bootstrap primary color */
            text-align: center;
            font-size: 1.75rem; /* Increased font size */
            margin-bottom: 20px; /* Added space below title */
        }
        label {
            font-weight: bold;
            color: #333;
            font-size: 0.95rem; /* Slightly larger font size */
        }
        input[type="text"], input[type="email"], input[type="password"] {
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            font-size: 0.95rem; /* Slightly larger font size */
        }
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus {
            border-color: #007bff; /* Change border color to blue */
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Blue shadow */
        }
        .btn-custom {
            background-color: #007bff; /* Bootstrap primary color */
            color: white;
            font-size: 1rem; /* Larger font size */
            padding: 10px; /* Added padding */
            transition: background-color 0.3s, transform 0.3s; /* Transition effects */
        }
        .btn-custom:hover {
            background-color: #0056b3; /* Darker shade of blue on hover */
            transform: translateY(-2px); /* Slight lift effect on hover */
        }
        .link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem; /* Slightly larger font size */
        }
        .link a {
            color: #007bff; /* Link color */
            text-decoration: none;
        }
        .link a:hover {
            text-decoration: underline; /* Underline on hover */
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Host Signup</h2>
        <form action="${pageContext.request.contextPath}/api/users/hostSignup" method="post">
            <input type="hidden" name="role" value="host">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control form-control-lg" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control form-control-lg" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control form-control-lg" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="profile">Profile:</label>
                <input type="text" class="form-control form-control-lg" id="profile" name="profile">
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control form-control-lg" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="phoneno">Phone No:</label>
                <input type="text" class="form-control form-control-lg" id="phoneno" name="phoneno" required>
            </div>
            <button type="submit" class="btn btn-custom btn-block">Sign Up</button>
        </form>

        <div class="link">
            <p>Already have an account? <a href="/api/users/hostLogin">Login here</a></p>
            <p><a href="/api/properties/all">Back to Role Selection</a></p>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
