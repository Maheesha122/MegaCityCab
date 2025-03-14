package servlets;

import dao.BookingDAO;
import dao.VehicleDAO;
import dao.DriverDAO;
import model.Vehicle;
import model.Driver;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ManageBooking")
public class ManageBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ManageBookingServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VehicleDAO vehicleDAO = VehicleDAO.getInstance();
        DriverDAO driverDAO = DriverDAO.getInstance();

        List<Vehicle> vehicles = vehicleDAO.getAllVehicles();
        List<Driver> drivers = driverDAO.getAllDrivers();

        request.setAttribute("vehicles", vehicles);
        request.setAttribute("drivers", drivers);

        request.getRequestDispatcher("/manageBookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingIDStr = request.getParameter("bookingID");
        String newStatus = request.getParameter("newStatus");
        String vehicleIDStr = request.getParameter("vehicleID");
        String driverIDStr = request.getParameter("driverID");
        String vehicleName = request.getParameter("vehicleName");

        BookingDAO bookingDAO = BookingDAO.getInstance();
        VehicleDAO vehicleDAO = VehicleDAO.getInstance();

        try {
            if (!isNullOrEmpty(vehicleName) && allParamsEmpty(bookingIDStr, newStatus, vehicleIDStr, driverIDStr)) {
                handleVehicleNameRequest(vehicleName, vehicleDAO, response);
                return;
            }

            if (!isNullOrEmpty(bookingIDStr) && !isNullOrEmpty(newStatus) && allParamsEmpty(vehicleIDStr, driverIDStr)) {
                int bookingID = Integer.parseInt(bookingIDStr);
                boolean isUpdated = bookingDAO.updateBookingStatus(bookingID, newStatus);
                response.sendRedirect(request.getContextPath() + "/admin/manageBookings.jsp?status=" + (isUpdated ? "success" : "failed"));
                return;
            }

            if (!isNullOrEmpty(bookingIDStr, newStatus, vehicleIDStr, driverIDStr)) {
                int bookingID = Integer.parseInt(bookingIDStr);
                int vehicleID = Integer.parseInt(vehicleIDStr);
                int driverID = Integer.parseInt(driverIDStr);

                boolean isUpdated = bookingDAO.updateBookingWithVehicleAndDriver(bookingID, newStatus, vehicleID, driverID);
                response.sendRedirect(request.getContextPath() + "/admin/manageBookings.jsp?status=" + (isUpdated ? "success" : "failed"));
                return;
            }

            response.getWriter().write("Invalid request. Please provide valid parameters.");
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid input. Ensure IDs are valid numbers.");
        }
    }

    private void handleVehicleNameRequest(String vehicleName, VehicleDAO vehicleDAO, HttpServletResponse response) throws IOException {
        List<Integer> vehicleIDs = vehicleDAO.getVehicleIDsByName(vehicleName);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (vehicleIDs.isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        String jsonResponse = "[" + String.join(",", vehicleIDs.stream().map(String::valueOf).toArray(String[]::new)) + "]";
        response.getWriter().write(jsonResponse);
    }

    private boolean isNullOrEmpty(String... values) {
        for (String value : values) {
            if (value == null || value.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    private boolean allParamsEmpty(String... params) {
        for (String param : params) {
            if (param != null && !param.trim().isEmpty()) {
                return false;
            }
        }
        return true;
    }
}
