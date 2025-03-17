<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Booking</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Page Styles */
        body {
            background-color: #007BFF; /* Blue background */
            color: #fff; /* White text */
        }
        
        /* Custom Card Styles */
        .card-custom {
            background-color: #FFD700; /* Yellow background */
            color: #000; /* Black text inside card */
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        /* Button Styles */
        button {
            background-color: #0056b3; /* Darker Blue button */
            color: #FFD700; /* Yellow text */
            border: none;
            padding: 12px 24px;
            font-size: 1.2rem;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }
        
        button:hover {
            background-color: #003f7f;
        }
    </style>
</head>
<body>
    <%@ include file="navBar.jsp" %>

    <!-- Center the card both vertically and horizontally -->
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="card card-custom text-center w-50">
            <h2 class="mb-4">Booking Details</h2>

            <p><strong>Total Bill:</strong> ${bill} LKR</p>
            <p><strong>Pickup Location:</strong> ${pickup}</p>
            <p><strong>Drop Location:</strong> ${drop}</p>
            <p><strong>Vehicle:</strong> ${vehicleType}</p>
            <p><strong>Date:</strong> ${date}</p>
            <p><strong>Time:</strong> ${time}</p>

            <!-- Booking Confirmation Form -->
            <form action="${pageContext.request.contextPath}/ConfirmBooking" method="POST">
                <input type="hidden" name="pickup" value="${pickup}" />
                <input type="hidden" name="drop" value="${drop}" />
                <input type="hidden" name="vehicleType" value="${vehicleType}" />
                <input type="hidden" name="date" value="${date}" />
                <input type="hidden" name="time" value="${time}" />
                <input type="hidden" name="bill" value="${bill}" />
                <input type="hidden" name="vehicleID" value="0" />
                <input type="hidden" name="driverID" value="0" />
                <input type="hidden" name="bookingStatus" value="Pending" />
                <div class="mt-4">
                    <button type="submit">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>