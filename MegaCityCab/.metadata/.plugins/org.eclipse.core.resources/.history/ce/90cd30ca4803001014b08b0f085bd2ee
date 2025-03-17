<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
    /* Internal CSS for the home page */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
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
    }

    .background-image {
        width: 100%;
        height: auto;
        display: block;
    }

    .overlay {
        position: absolute;
        top: 40%;
        left: 30%;
        transform: translate(-50%, -50%);
        background-color: rgba(0, 0, 0, 0.7);
        padding: 20px;
        border-radius: 10px;
        text-align: center;
    }

    .overlay a {
        display: inline-block;
        background-color: yellow;
        color: black;
        padding: 10px 20px;
        text-decoration: none;
        font-size: 18px;
        border-radius: 5px;
        margin-top: 10px;
    }

    .overlay a:hover {
        background-color: black;
        color: yellow;
    }

    .vehicles-image {
        width: 100%;
        height: auto;
        display: block;
    }
</style>
</head>
<body>

    <%@ include file="navBar.jsp" %>

    <!-- Main Image Section -->
    <div class="image-container">
        <img src="../images/main.jpg" alt="Main Image" class="background-image">
        
        <!-- Overlay Text and Button -->
        <div class="overlay">
            <h1>Enjoy a reliable journey with Mega City Cabs</h1>
            <a href="<%= session.getAttribute("user_email") != null ? "../booking" : "../authentication/signIn.jsp" %>">
                BOOK NOW
            </a>
        </div>
    </div>

    <!-- Vehicles Image Section -->
    <div class="image-container">
        <img src="../images/vehicles_image.png" alt="Vehicles Image" class="vehicles-image">
    </div>

</body>
</html>
