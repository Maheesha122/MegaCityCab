package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.DriverDAO;
import model.Driver;

@WebServlet("/ManageDrivers")
public class ManageDriversServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ManageDriversServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverID = request.getParameter("driverID");

        try {
            if (!isNullOrEmpty(driverID)) {
                handleDriverDeletion(driverID, response);
            } else {
                handleDriverAddition(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/manageDrivers.jsp?error=invalidInput");
        }
    }

    private void handleDriverDeletion(String driverID, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(driverID);
        boolean isDeleted = DriverDAO.getInstance().deleteDriver(id);
        response.sendRedirect("admin/manageDrivers.jsp?" + (isDeleted ? "deleteSuccess=true" : "deleteError=true"));
    }

    private void handleDriverAddition(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String driverName = request.getParameter("driverName");
        String driverNIC = request.getParameter("driverNIC");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        if (isNullOrEmpty(driverName, driverNIC, phoneNumber, address)) {
            response.sendRedirect("admin/manageDrivers.jsp?error=missingFields");
            return;
        }

        Driver driver = new Driver();
        driver.setDriverName(driverName);
        driver.setDriverNIC(driverNIC);
        driver.setPhoneNumber(phoneNumber);
        driver.setAddress(address);

        boolean isAdded = DriverDAO.getInstance().addDriver(driver);
        response.sendRedirect("admin/manageDrivers.jsp?" + (isAdded ? "success=true" : "error=true"));
    }

    private boolean isNullOrEmpty(String... values) {
        for (String value : values) {
            if (value == null || value.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }
}
