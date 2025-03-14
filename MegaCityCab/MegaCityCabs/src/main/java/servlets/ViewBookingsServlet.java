package servlets;

import dao.BookingDAO;
import model.Booking;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewBookings")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BookingDAO bookingDAO = BookingDAO.getInstance(); // Singleton DAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user_email") == null) {
            response.sendRedirect("authentication/signIn.jsp"); // Redirect to login if not logged in
            return;
        }

        // Get the logged-in user
        String email = (String) session.getAttribute("user_email");
        String role = (String) session.getAttribute("user_role");

        // Admin Role Check: Allow only admin to view all bookings
        if (!"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("customer/home.jsp"); // Redirect unauthorized users
            return;
        }

        try {
            // Retrieve all bookings from the database
            List<Booking> bookings = bookingDAO.getAllBookings();

            // Check if bookings are found
            if (bookings == null || bookings.isEmpty()) {
                request.setAttribute("message", "No bookings found.");
            } else {
                request.setAttribute("bookings", bookings);
            }

            // Forward to the admin bookings page
            request.getRequestDispatcher("/admin/viewBookings.jsp").forward(request, response);

        } catch (Exception e) {
            // Log and handle exception
            e.printStackTrace();
            request.setAttribute("message", "Error retrieving bookings.");
            request.getRequestDispatcher("/admin/viewBookings.jsp").forward(request, response);
        }
    }
}
