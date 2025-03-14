package dao;

import model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import database.DatabaseConnection;

public class BookingDAO {
    private static BookingDAO instance;
    private final Connection connection;
    private static final Logger LOGGER = Logger.getLogger(BookingDAO.class.getName());

    private BookingDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    public static BookingDAO getInstance() {
        if (instance == null) {
            synchronized (BookingDAO.class) {
                if (instance == null) {
                    instance = new BookingDAO();
                }
            }
        }
        return instance;
    }

    public boolean addBooking(Booking booking) {
        String query = "INSERT INTO bookings (customerID, vehicleType, vehicleID, driverID, rentalDate, rentalTime, " +
                       "pickupLocation, dropLocation, bill, bookingStatus, paymentStatus) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, booking.getCustomerID());
            stmt.setString(2, booking.getVehicleType());
            stmt.setInt(3, booking.getVehicleID());
            stmt.setInt(4, booking.getDriverID());
            stmt.setString(5, booking.getRentalDate());
            stmt.setString(6, booking.getRentalTime());
            stmt.setString(7, booking.getPickupLocation());
            stmt.setString(8, booking.getReturnLocation());
            stmt.setDouble(9, booking.getBill());
            stmt.setString(10, booking.getBookingStatus());

            // Debugging: Print all values being inserted
            System.out.println("Inserting Booking:");
            System.out.println("Customer ID: " + booking.getCustomerID());
            System.out.println("Vehicle Type: " + booking.getVehicleType());
            System.out.println("Vehicle ID: " + booking.getVehicleID());
            System.out.println("Driver ID: " + booking.getDriverID());
            System.out.println("Rental Date: " + booking.getRentalDate());
            System.out.println("Rental Time: " + booking.getRentalTime());
            System.out.println("Pickup Location: " + booking.getPickupLocation());
            System.out.println("Return Location: " + booking.getReturnLocation());
            System.out.println("Bill: " + booking.getBill());
            System.out.println("Booking Status: " + booking.getBookingStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    System.out.println("Booking added successfully! Generated Booking ID: " + generatedId);
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding booking to the database", e);
        }
        return false;
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("bookingID"));
                booking.setCustomerID(rs.getInt("customerID"));
                booking.setVehicleType(rs.getString("vehicleType"));
                booking.setVehicleID(rs.getInt("vehicleID"));
                booking.setDriverID(rs.getInt("driverID"));
                booking.setRentalDate(rs.getString("rentalDate"));
                booking.setRentalTime(rs.getString("rentalTime"));
                booking.setPickupLocation(rs.getString("pickupLocation"));
                booking.setReturnLocation(rs.getString("dropLocation"));
                booking.setBill(rs.getDouble("bill"));
                booking.setBookingStatus(rs.getString("bookingStatus"));

                bookings.add(booking);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving bookings from the database", e);
        }

        return bookings;
    }

    // Method to get bookings by customerID
    public List<Booking> getBookingsByCustomerID(int customerID) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE customerID = ?";
        
        System.out.println("SQL Query: " + query + " for customerID: " + customerID); // Debugging line
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("bookingID"));
                booking.setCustomerID(rs.getInt("customerID"));
                booking.setVehicleType(rs.getString("vehicleType"));
                booking.setVehicleID(rs.getInt("vehicleID"));
                booking.setDriverID(rs.getInt("driverID"));
                booking.setRentalDate(rs.getString("rentalDate"));
                booking.setRentalTime(rs.getString("rentalTime"));
                booking.setPickupLocation(rs.getString("pickupLocation"));
                booking.setReturnLocation(rs.getString("dropLocation"));
                
                // Make sure to remove or modify the reference to 'returnLocation' if it's not in the table
               
                
                booking.setBill(rs.getDouble("bill"));
                booking.setBookingStatus(rs.getString("bookingStatus"));
                
                bookings.add(booking);
            }
            
            System.out.println("Bookings retrieved: " + bookings.size());  // Debugging line
        } catch (SQLException e) {
            e.printStackTrace();  // Debugging line
        }
        
        return bookings;
    }
    private List<Booking> getBookingsByStatus(String status) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE bookingStatus = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("bookingID"));
                booking.setCustomerID(rs.getInt("customerID"));
                booking.setVehicleType(rs.getString("vehicleType"));
                booking.setVehicleID(rs.getInt("vehicleID"));
                booking.setDriverID(rs.getInt("driverID"));
                booking.setRentalDate(rs.getString("rentalDate"));
                booking.setRentalTime(rs.getString("rentalTime"));
                booking.setPickupLocation(rs.getString("pickupLocation"));
                booking.setReturnLocation(rs.getString("dropLocation"));
                booking.setBill(rs.getDouble("bill"));
                booking.setBookingStatus(rs.getString("bookingStatus"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving bookings with status: " + status, e);
        }

        return bookings;
    }

    // Methods for specific statuses
    public List<Booking> getPendingBookings() {
        return getBookingsByStatus("Pending");
    }

    public List<Booking> getBookedBookings() {
        return getBookingsByStatus("Booked");
    }

    public List<Booking> getCompletedBookings() {
        return getBookingsByStatus("Completed");
    }

    public List<Booking> getCancelledBookings() {
        return getBookingsByStatus("Cancelled");
    }
    
    public boolean updateBookingStatus(int bookingID, String newStatus) {
        String query = "UPDATE bookings SET bookingStatus = ? WHERE bookingID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, bookingID);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("Booking status updated successfully! Booking ID: " + bookingID);
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating booking status for bookingID: " + bookingID, e);
        }

        return false;
    }
    
    public boolean updateBookingWithVehicleAndDriver(int bookingID, String newStatus, int vehicleID, int driverID) {
        String query = "UPDATE bookings SET bookingStatus = ?, vehicleID = ?, driverID = ? WHERE bookingID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, vehicleID);
            stmt.setInt(3, driverID);
            stmt.setInt(4, bookingID);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("Booking updated successfully with vehicle and driver. Booking ID: " + bookingID);
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating booking with vehicle and driver for bookingID: " + bookingID, e);
        }

        return false;
    }


}



