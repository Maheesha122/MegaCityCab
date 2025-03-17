<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        background-color: #f0f8ff; /* Light background color */
    }

    h1 {
        text-align: center;
        color: black;
        background-color: #ffcc00; /* Yellow background */
        margin: 0;
        padding: 20px;
    }

    .faq-container {
        padding: 20px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
        max-width: 800px;
    }

    .faq-container h2 {
        text-align: center;
        color: #003366; /* Dark blue color */
        margin-bottom: 20px;
    }

    .faq-item {
        margin-bottom: 15px;
    }

    .faq-item h3 {
        color: #ffcc00; /* Yellow color */
        background-color: #003366; /* Blue background */
        padding: 10px;
        border-radius: 5px;
    }

    .faq-item p {
        padding: 10px;
        background-color: #f0f8ff; /* Light blue background */
        border-radius: 5px;
    }

    .image-container {
        position: relative;
        text-align: center;
    }

    .background-image {
        width: 100%; /* Make main image fit the screen width */
        height: auto;
        display: block;
    }

    .overlay {
        position: absolute;
        top: 40%; /* Adjusted to move text higher */
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: rgba(0, 0, 0, 0.7); /* Black rectangle with some transparency */
        padding: 20px;
        border-radius: 10px;
        text-align: center;
    }

    .overlay a {
        display: inline-block;
        background-color: #ffcc00; /* Yellow background */
        color: black;
        padding: 10px 20px;
        text-decoration: none;
        font-size: 18px;
        border-radius: 5px;
        margin-top: 10px;
    }

    .overlay a:hover {
        background-color: #003366; /* Blue background */
        color: yellow;
    }

    .vehicles-image {
        width: 100%; /* Make vehicle image fit the screen width */
        height: auto;
        display: block;
    }
</style>
</head>
<body>

    <%@ include file="navBar.jsp" %>
    <div class="faq-container">
        <h2>Frequently Asked Questions (FAQs)</h2>
        
        <div class="faq-item">
            <h3>1. Do I need to pay in advance?</h3>
            <p>No, you can pay at the end of the ride. Pay as you go!</p>
        </div>

        <div class="faq-item">
            <h3>2. Can I cancel my booking?</h3>
            <p>Yes, cancel your booking up to 30 minutes before the ride without any charges. Just inform us by phone!</p>
        </div>

        <div class="faq-item">
            <h3>3. What payment methods are accepted?</h3>
            <p>We accept cash, credit/debit cards, and popular digital wallets for your convenience.</p>
        </div>

        <div class="faq-item">
            <h3>4. Are there any additional charges?</h3>
            <p>No hidden fees. What you see is the final fare.</p>
        </div>

        <div class="faq-item">
            <h3>5. How do I contact customer support?</h3>
            <p>Reach us by calling our support hotline or email us at support@megacitycab.com for assistance.</p>
        </div>

        <div class="faq-item">
            <h3>6. Can I request a specific driver?</h3>
            <p>If your preferred driver is available, we’ll be happy to assign them to your ride.</p>
        </div>
    </div>
   

</body>
</html>
