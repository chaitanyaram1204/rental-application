<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #e9ecef;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .alert {
            color: red;
            margin-bottom: 15px;
            border: 1px solid red;
            padding: 10px;
            background-color: #f8d7da;
            display: inline-block;
        }
        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            animation: fadeIn 0.5s ease-in-out;
            width: 100%;
            max-width: 400px; /* Responsive max-width */
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .login-title {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
        }
        .btn-custom {
            background-color: #007bff; /* Bootstrap primary color */
            color: white;
            transition: background-color 0.3s;
        }
        .btn-custom:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }
        .footer-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
        }
        .footer-link a {
            color: #007bff; /* Link color */
            text-decoration: none;
        }
        .footer-link a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <div class="login-container">
    <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="alert" role="alert">
                <%= errorMessage %>
            </div>
        <%
            }
        %>
        <h2 class="login-title"><i class="fas fa-user-circle"></i> Guest Login</h2>
        <form action="${pageContext.request.contextPath}/api/users/guestLogin" method="post">
            <input type="hidden" name="role" value="guest">
            <div class="form-group">
                <label for="loginEmail">Email:</label>
                <input type="email" id="loginEmail" name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="loginPassword">Password:</label>
                <input type="password" id="loginPassword" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-custom btn-block">Login</button>
        </form>

        <div class="footer-link">
            <p>Don't have an account? <a href="/api/users/guestSignup">Create an account</a></p>
            <p><a href="/api/properties/all">Back to Role Selection</a></p>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
