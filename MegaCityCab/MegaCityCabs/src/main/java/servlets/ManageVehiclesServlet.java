package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.VehicleDAO;
import model.Vehicle;

@WebServlet("/ManageVehicles")
public class ManageVehiclesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ManageVehiclesServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");

        try {
            if (!isNullOrEmpty(vehicleID)) {
                handleVehicleDeletion(vehicleID, response);
            } else {
                handleVehicleAddition(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/manageVehicles.jsp?error=invalidInput");
        }
    }

    private void handleVehicleDeletion(String vehicleID, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(vehicleID);
        boolean isDeleted = VehicleDAO.getInstance().deleteVehicle(id);
        response.sendRedirect("admin/manageVehicles.jsp?" + (isDeleted ? "deleteSuccess=true" : "deleteError=true"));
    }

    private void handleVehicleAddition(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String vehicleName = request.getParameter("vehicleName");
        String model = request.getParameter("model");
        String brand = request.getParameter("brand");
        String year = request.getParameter("year");
        String registrationNumber = request.getParameter("registrationNumber");
        String seatingCapacityStr = request.getParameter("seatingCapacity");
        String fuelType = request.getParameter("fuelType");
        String ratePerDayStr = request.getParameter("ratePerDay");

        if (isNullOrEmpty(vehicleName, model, brand, year, registrationNumber, seatingCapacityStr, fuelType, ratePerDayStr)) {
            response.sendRedirect("admin/manageVehicles.jsp?error=missingFields");
            return;
        }

        try {
            int seatingCapacity = Integer.parseInt(seatingCapacityStr);
            double ratePerDay = Double.parseDouble(ratePerDayStr);

            Vehicle vehicle = new Vehicle();
            vehicle.setVehicleName(vehicleName);
            vehicle.setModel(model);
            vehicle.setBrand(brand);
            vehicle.setYear(year);
            vehicle.setRegistrationNumber(registrationNumber);
            vehicle.setSeatingCapacity(seatingCapacity);
            vehicle.setFuelType(fuelType);
            vehicle.setRatePerDay(ratePerDay);

            boolean isAdded = VehicleDAO.getInstance().addVehicle(vehicle);
            response.sendRedirect("admin/manageVehicles.jsp?" + (isAdded ? "success=true" : "error=true"));
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/manageVehicles.jsp?error=invalidNumberFormat");
        }
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
