<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetchBookings();
        });

        // Fetch all bookings
        function fetchBookings() {
            fetch('/api/bookings')  // Example endpoint to fetch bookings
                .then(response => response.json())
                .then(data => {
                    renderBookings(data);
                })
                .catch(error => console.error('Error fetching bookings:', error));
        }

        // Render bookings dynamically using JavaScript
        function renderBookings(bookings) {
            const pendingTableBody = document.querySelector('#pendingBookings tbody');
            const bookedTableBody = document.querySelector('#bookedBookings tbody');
            const completedTableBody = document.querySelector('#completedBookings tbody');
            const cancelledTableBody = document.querySelector('#cancelledBookings tbody');

            bookings.forEach(booking => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${booking.bookingID}</td>
                    <td>${booking.customerID}</td>
                    <td>${booking.vehicleType}</td>
                    <td>${booking.vehicleID}</td>
                    <td>${booking.driverID}</td>
                    <td>${booking.rentalDate}</td>
                    <td>${booking.rentalTime}</td>
                    <td>${booking.pickupLocation}</td>
                    <td>${booking.returnLocation}</td>
                    <td>Rs. ${booking.bill}</td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="openManagePopup(${booking.bookingID})">Manage</button>
                        <button class="btn btn-danger btn-sm" onclick="cancelBooking(${booking.bookingID})">Cancel</button>
                    </td>
                `;
                if (booking.status === "pending") {
                    pendingTableBody.appendChild(row);
                } else if (booking.status === "booked") {
                    bookedTableBody.appendChild(row);
                } else if (booking.status === "completed") {
                    completedTableBody.appendChild(row);
                } else if (booking.status === "cancelled") {
                    cancelledTableBody.appendChild(row);
                }
            });
        }

        // Open the modal to manage the booking
        function openManagePopup(bookingID) {
            document.getElementById('popup-bookingID').value = bookingID;
            fetch(`/api/vehicles`)
                .then(response => response.json())
                .then(data => {
                    const vehicleSelect = document.getElementById('vehicleID');
                    data.forEach(vehicle => {
                        const option = document.createElement('option');
                        option.value = vehicle.vehicleID;
                        option.textContent = `${vehicle.vehicleID} - ${vehicle.vehicleName}`;
                        vehicleSelect.appendChild(option);
                    });
                });

            fetch(`/api/drivers`)
                .then(response => response.json())
                .then(data => {
                    const driverSelect = document.getElementById('driverID');
                    data.forEach(driver => {
                        const option = document.createElement('option');
                        option.value = driver.driverID;
                        option.textContent = `${driver.driverID} - ${driver.driverName}`;
                        driverSelect.appendChild(option);
                    });
                });

            const myModal = new bootstrap.Modal(document.getElementById('manageModal'));
            myModal.show();
        }

        // Cancel the booking
        function cancelBooking(bookingID) {
            fetch(`/api/manageBooking`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ bookingID, newStatus: 'Cancelled' })
            })
            .then(response => response.json())
            .then(() => {
                alert('Booking Cancelled');
                fetchBookings();  // Reload bookings
            })
            .catch(error => console.error('Error cancelling booking:', error));
        }
    </script>
</head>
<body>
    <%@ include file="navBar.jsp" %>

    <div class="container mt-4">
        <h2 class="text-center mb-4">Manage Bookings</h2>

        <!-- Pending Bookings Table -->
        <h3 class="mt-4">Pending Bookings</h3>
        <table class="table table-striped table-bordered" id="pendingBookings">
            <thead class="table-warning">
                <tr>
                    <th>Booking ID</th>
                    <th>Customer ID</th>
                    <th>Vehicle Type</th>
                    <th>Vehicle ID</th>
                    <th>Driver ID</th>
                    <th>Rental Date</th>
                    <th>Rental Time</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Bill</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <!-- Bookings will be dynamically loaded here -->
            </tbody>
        </table>

        <!-- More tables (Booked, Completed, Cancelled) go here with the same structure -->

    </div>

    <!-- Popup Modal for Managing Booking -->
    <div class="modal fade" id="manageModal" tabindex="-1" aria-labelledby="manageModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="manageModalLabel">Manage Booking</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="manageBookingForm" method="post">
                        <input type="hidden" id="popup-bookingID" name="bookingID">
                        <div class="mb-3">
                            <label for="vehicleID" class="form-label">Assign Vehicle</label>
                            <select class="form-select" name="vehicleID" id="vehicleID" required>
                                <option value="" selected>Select a vehicle</option>
                                <!-- Options will be populated by JavaScript -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="driverID" class="form-label">Assign Driver</label>
                            <select class="form-select" name="driverID" id="driverID" required>
                                <option value="" selected>Select a driver</option>
                                <!-- Options will be populated by JavaScript -->
                            </select>
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-success">Book</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
