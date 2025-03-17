<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .status-confirmed {
            color: #28a745;
        }
        .status-pending {
            color: #ffc107;
        }
        .status-cancelled {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <%@ include file="navBar.jsp" %>  <!-- Ensure navBar.jsp is accessible -->

    <div class="container mt-4">
        <div class="table-container p-4">
            <h1 class="text-center">My Bookings</h1>

            <c:choose>
                <c:when test="${not empty bookings}">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking ID</th>
                                <th>Vehicle Type</th>
                                <th>Vehicle ID</th>
                                <th>Driver ID</th>
                                <th>Rental Date</th>
                                <th>Rental Time</th>
                                <th>Pickup Location</th>
                                <th>Drop Location</th>
                                <th>Bill (Rs.)</th>
                                <th>Booking Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookings}">
                                <tr>
                                    <td><c:out value="${booking.bookingID}"/></td>
                                    <td><c:out value="${booking.vehicleType}"/></td>
                                    <td><c:out value="${booking.vehicleID}"/></td>
                                    <td><c:out value="${booking.driverID}"/></td>
                                    <td><c:out value="${booking.rentalDate}"/></td>
                                    <td><c:out value="${booking.rentalTime}"/></td>
                                    <td><c:out value="${booking.pickupLocation}"/></td>
                                    <td><c:out value="${booking.returnLocation}"/></td>
                                    <td>Rs. <c:out value="${booking.bill}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.bookingStatus == 'Confirmed'}">
                                                <span class="status-confirmed"><c:out value="${booking.bookingStatus}"/></span>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'Pending'}">
                                                <span class="status-pending"><c:out value="${booking.bookingStatus}"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-cancelled"><c:out value="${booking.bookingStatus}"/></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info text-center">No bookings found.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

---

### **Next Steps to Fix 404 Error**
If you're still getting the **HTTP Status 404 – Not Found** error, try these fixes:  

#### ✅ **1. Ensure the JSP File is in the Correct Location**
- `my_bookings.jsp` should be in `webapps/MegaCityCabs/customer/`.
- If your JSP files are in `WEB-INF/views/`, then it should be accessed via a controller (Spring MVC).

#### ✅ **2. Check Deployment in Tomcat**
- Confirm that the application is correctly deployed under `webapps/MegaCityCabs/` by checking:
  - `webapps/MegaCityCabs/customer/my_bookings.jsp` exists.
  - If you are using **Spring MVC**, make sure a controller is correctly mapped.
  - Restart Tomcat (`shutdown.sh` or `catalina.bat stop` → `startup.sh` or `catalina.bat start`).
  - Check **Tomcat logs** (`logs/catalina.out`) for errors.

#### ✅ **3. Check the URL**
- Make sure the URL path matches the JSP file location. If using a framework:
  - It could be `http://localhost:8080/MegaCityCabs/customer/my_bookings.jsp`
  - If using a **Servlet**, ensure the `web.xml` is configured properly.
  - If using **Spring**, check the controller is mapped to serve this JSP.

#### ✅ **4. Verify Deployment on Tomcat**
- If you **recently deployed** changes, **restart the server**.
- Check `webapps/MegaCityCabs/customer/` to confirm the file is present.

---

### **Let me know if:**
- You need **help debugging Tomcat or deployment issues**.
- You’re using **Spring MVC**, and I can guide you on how to properly map your view.
- You need additional improvements for your JSP structure.

Hope this helps! 🚀
