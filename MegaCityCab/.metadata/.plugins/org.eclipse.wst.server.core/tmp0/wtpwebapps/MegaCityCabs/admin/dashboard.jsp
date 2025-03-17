<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e9f5e1;  /* Light green background */
        }

        h1 {
            text-align: center;
            color: white;
            margin: 0;
            padding: 20px;
        }

        .image-container {
            position: relative;
            text-align: center;
            height: 100vh;
            overflow: hidden;
        }

        .background-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 128, 0, 0.7);  /* Green overlay */
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            max-width: 600px;
        }

        .overlay h2 {
            color: white;
            font-size: 36px;
            margin-bottom: 20px;
        }

        .overlay p {
            color: white;
            font-size: 18px;
            margin-bottom: 30px;
        }

    </style>
</head>
<body>

    <%@ include file="navBar.jsp" %>

    <div class="image-container">
        <img src="https://images.unsplash.com/photo-1556740749-887f6717d7e4" alt="Admin Dashboard Background" class="background-image">
        <div class="overlay">
            <h2>Welcome, MegaCityCab Admin Dashboard</h2>
        </div>
    </div>

</body>
</html>
