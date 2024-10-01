<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Form</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .container {
            max-width: 600px;
            margin-top: 50px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }

        .container:hover {
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.15);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
            font-size: 2rem;
            letter-spacing: 1px;
        }

        .form-group label {
            font-weight: 600;
            color: #333;
        }

        .form-control {
            border: 2px solid #ddd;
            border-radius: 8px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.25);
        }

        .form-check-label {
            font-weight: 500;
            margin-left: 5px;
            color: #333;
        }

        .form-check-input:focus {
            outline: 2px solid #007bff;
        }

        button {
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-size: 1.2rem;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        button:focus {
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
            outline: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Property Form</h1>
        <form action="${pageContext.request.contextPath}/api/properties/create" method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required />
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" class="form-control" id="category" name="category" required />
            </div>

            <div class="form-group">
                <label for="cost">Cost:</label>
                <input type="number" class="form-control" id="cost" name="cost" step="0.01" required />
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
            </div>

            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="availability" name="availability" />
                <label class="form-check-label" for="availability">Available</label>
            </div>

            <div class="form-group">
                <label for="location">Location:</label>
                <input type="text" class="form-control" id="location" name="location" required />
            </div>

            <div class="form-group">
                <label for="capacity">Capacity:</label>
                <input type="number" class="form-control" id="capacity" name="capacity" required />
            </div>

            <!-- Hidden field to pass hostId -->
            <input type="hidden" id="hostId" name="hostId" value="${hostId}" />

            <button type="submit" class="btn btn-primary btn-block">Submit</button>
            <!-- Back to Dashboard button -->
            <button type="button" class="btn btn-secondary btn-block mt-3" onclick="goBack()">Back to Dashboard</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function goBack() {
            // Redirect to host dashboard
            window.location.href = "${pageContext.request.contextPath}/api/users/host-dashboard";
        }
    </script>
</body>
</html>
