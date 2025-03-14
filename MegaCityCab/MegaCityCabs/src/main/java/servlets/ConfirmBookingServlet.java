package servlets;

import dao.BookingDAO;
import dao.UserDAO;
import model.Booking;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ConfirmBooking")
public class ConfirmBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BookingDAO bookingDAO = BookingDAO.getInstance();
    private final UserDAO userDAO = UserDAO.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user_email from session
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user_email");

        if (userEmail == null) {
            request.setAttribute("message", "Booking failed. Please log in first.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Get User by email
        User user = userDAO.getUserByEmail(userEmail);
        if (user == null) {
            request.setAttribute("message", "Booking failed. User not found.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Extract form data
        String vehicleType = request.getParameter("vehicleType");
        String vehicleID = request.getParameter("vehicleID");
        String driverID = request.getParameter("driverID");
        String rentalDate = request.getParameter("date");
        String rentalTime = request.getParameter("time");
        String pickupLocation = request.getParameter("pickup");
        String returnLocation = request.getParameter("drop");
        String bill = request.getParameter("bill");

        // Validate input fields
        if (isNullOrEmpty(vehicleType, vehicleID, driverID, rentalDate, rentalTime, pickupLocation, returnLocation, bill)) {
            request.setAttribute("message", "Booking failed. Missing required information.");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
            return;
        }

        try {
            // Validate numeric fields before parsing
            if (!isNumeric(vehicleID) || !isNumeric(driverID) || !isNumeric(bill)) {
                request.setAttribute("message", "Booking failed due to invalid number format.");
                request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
                return;
            }

            // Create booking object
            Booking booking = new Booking();
            booking.setCustomerID(user.getUserID());
            booking.setVehicleType(vehicleType);
            booking.setVehicleID(Integer.parseInt(vehicleID));
            booking.setDriverID(Integer.parseInt(driverID));
            booking.setRentalDate(rentalDate);
            booking.setRentalTime(rentalTime);
            booking.setPickupLocation(pickupLocation);
            booking.setReturnLocation(returnLocation);
            booking.setBill(Double.parseDouble(bill));
            booking.setBookingStatus("Pending");

            // Add booking to database
            boolean isBookingAdded = bookingDAO.addBooking(booking);

            if (isBookingAdded) {
                response.sendRedirect(request.getContextPath() + "/MyBookings");
            } else {
                request.setAttribute("message", "Booking confirmation failed. Please try again.");
                request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Booking failed due to invalid number format.");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Booking failed due to an unexpected error. Please try again.");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        }
    }

    // Helper method to check if any input is null or empty
    private boolean isNullOrEmpty(String... values) {
        for (String value : values) {
            if (value == null || value.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    // Helper method to check if a string is numeric
    private boolean isNumeric(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
