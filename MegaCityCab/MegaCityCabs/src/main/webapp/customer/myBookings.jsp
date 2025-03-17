<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff; /* Light Blue */
        }
        .container {
            margin-top: 30px;
        }
        .booking-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
            border-left: 5px solid #FFD700; /* Yellow Accent */
        }
        .booking-title {
            color: #0056b3;
            font-weight: bold;
        }
        .status-confirmed {
            color: #28a745;
            font-weight: bold;
        }
        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }
        .status-cancelled {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@ include file="navBar.jsp" %>

    <div class="container">
        <h1 class="text-center text-primary">My Bookings</h1>
        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="row">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="col-md-6">
                            <div class="booking-card">
                                <h5 class="booking-title">Booking ID: ${booking.bookingID}</h5>
                                <p><strong>Vehicle Type:</strong> ${booking.vehicleType}</p>
                                <p><strong>Vehicle ID:</strong> ${booking.vehicleID}</p>
                                <p><strong>Driver ID:</strong> ${booking.driverID}</p>
                                <p><strong>Pickup:</strong> ${booking.pickupLocation}</p>
                                <p><strong>Drop:</strong> ${booking.returnLocation}</p>
                                <p><strong>Rental Date:</strong> ${booking.rentalDate} | <strong>Time:</strong> ${booking.rentalTime}</p>
                                <p><strong>Bill:</strong> Rs. ${booking.bill}</p>
                                <p><strong>Status:</strong>
                                    <c:choose>
                                        <c:when test="${booking.bookingStatus == 'Confirmed'}">
                                            <span class="status-confirmed">${booking.bookingStatus}</span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Pending'}">
                                            <span class="status-pending">${booking.bookingStatus}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-cancelled">${booking.bookingStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="alert alert-warning text-center">No bookings found.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
