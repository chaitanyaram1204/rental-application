<%-- guestSignup.jsp --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest Signup</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif; /* Updated font for a modern look */
        }
        .container {
            max-width: 500px;
            margin-top: 100px;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #007bff; /* Primary color for headings */
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            transition: background-color 0.3s ease; /* Smooth transition on hover */
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .form-control {
            border-radius: 5px; /* Rounded input fields */
            transition: border-color 0.3s ease; /* Smooth transition on focus */
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
        .alert {
            display: none; /* Hide alert initially */
        }
        .text-center a {
            color: #007bff; /* Link color */
        }
        .text-center a:hover {
            text-decoration: underline; /* Underline on hover */
        }
        @media (max-width: 576px) {
            .container {
                padding: 15px; /* Reduce padding on small screens */
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Guest Signup</h2>
    <div class="alert alert-danger" id="errorAlert"></div>
    <form id="signupForm" action="/api/users/guestSignup" method="post">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" id="name" name="name" required>
            <div class="invalid-feedback">Please enter your name.</div>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <div class="invalid-feedback">Please enter a valid email address.</div>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="invalid-feedback">Please enter a password.</div>
        </div>

        <div class="form-group">
            <label for="profile">Profile:</label>
            <input type="text" class="form-control" id="profile" name="profile">
        </div>

        <div class="form-group">
            <label for="address">Address:</label>
            <input type="text" class="form-control" id="address" name="address" required>
            <div class="invalid-feedback">Please enter your address.</div>
        </div>

        <div class="form-group">
            <label for="phoneno">Phone Number:</label>
            <input type="text" class="form-control" id="phoneno" name="phoneno" required pattern="\d{10}">
            <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
        </div>

        <input type="hidden" name="role" value="guest">
        <button type="submit" class="btn btn-custom btn-block">Sign Up</button>
    </form>

    <p class="text-center mt-3">Already have an account? <a href="/api/users/guestLogin">Login here</a></p>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('#signupForm').on('submit', function (e) {
            e.preventDefault();
            let valid = true;

            // Clear previous alerts
            $('#errorAlert').hide().text('');

            // Validate form fields
            $(this).find('input').each(function () {
                if (!this.checkValidity()) {
                    valid = false;
                    $(this).addClass('is-invalid');
                } else {
                    $(this).removeClass('is-invalid');
                }
            });

            if (!valid) {
                $('#errorAlert').text('Please fill in all required fields correctly.').show();
                return;
            }

            // If valid, submit the form
            this.submit();
        });
    });
</script>

</body>
</html>
