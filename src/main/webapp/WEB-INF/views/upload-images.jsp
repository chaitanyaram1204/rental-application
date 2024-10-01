<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Property Photo</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #007bff;
            text-align: center;
            margin-bottom: 30px;
        }
        label {
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
        }
        input[type="file"] {
            margin-bottom: 20px;
        }
        button {
            width: auto; /* Set width to auto for a smaller button */
            padding: 5px 15px; /* Adjust padding to decrease button size */
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block; /* Ensure button is centered */
            margin: 0 auto; /* Center the button */
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 20px;
            text-align: center;
        }
        .message p {
            margin: 0;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            text-align: center;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Upload Photo for Property</h2>

        <!-- Form that submits to /photos/upload/{propertyId} -->
        <form method="POST" enctype="multipart/form-data" action="/photos/upload/<%= request.getAttribute("propertyId") %>">
            <label for="file">Choose a photo:</label>
            <input type="file" id="file" name="file" accept="image/*" required>
            <button type="submit">Upload</button>
        </form>

        <!-- Show success message -->
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="message" style="color: green;">
                <p><%= request.getAttribute("successMessage") %></p>
            </div>
        <% } %>

        <!-- Show error message -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="message" style="color: red;">
                <p><%= request.getAttribute("errorMessage") %></p>
            </div>
        <% } %>
        
        <!-- Back link to the property details or photo listing -->
        <a href="/photos/<%= request.getAttribute("propertyId") %>/photos">Back to Property Photos</a>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
