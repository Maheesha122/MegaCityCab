<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Drivers</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Fetch the list of drivers and populate the table
        function fetchDrivers() {
            fetch('/api/drivers')
                .then(response => response.json())
                .then(drivers => {
                    const driverTableBody = document.getElementById('driverTableBody');
                    driverTableBody.innerHTML = '';
                    drivers.forEach(driver => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${driver.driverID}</td>
                            <td>${driver.driverName}</td>
                            <td>${driver.driverNIC}</td>
                            <td>${driver.phoneNumber}</td>
                            <td>${driver.address}</td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="deleteDriver(${driver.driverID})">❌</button>
                            </td>
                        `;
                        driverTableBody.appendChild(row);
                    });
                });
        }

        // Handle driver deletion
        function deleteDriver(driverID) {
            fetch(`/api/drivers/${driverID}`, { method: 'DELETE' })
                .then(response => {
                    if (response.ok) {
                        alert('Driver deleted successfully!');
                        fetchDrivers(); // Refresh the driver list
                    } else {
                        alert('Error deleting driver');
                    }
                });
        }

        // Handle adding a new driver
        function addDriver(event) {
            event.preventDefault();
            const driverName = document.getElementById('driverName').value;
            const driverNIC = document.getElementById('driverNIC').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            const address = document.getElementById('address').value;

            const driverData = { driverName, driverNIC, phoneNumber, address };

            fetch('/api/drivers', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(driverData)
            })
            .then(response => response.json())
            .then(() => {
                alert('Driver added successfully!');
                fetchDrivers(); // Refresh the driver list
                $('#addDriverModal').modal('hide'); // Close modal
            })
            .catch(() => alert('Error adding driver'));
        }

        // Initialize the page by fetching the drivers
        window.onload = fetchDrivers;
    </script>
</head>
<body>
    <!-- Include navigation bar here -->
    <!-- Example: <nav> ... </nav> -->

    <div class="container mt-4">
        <h1 class="mb-4 text-center">Manage Drivers</h1>

        <!-- Actions Table -->
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <td class="text-center">
                        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#addDriverModal">
                            Add Driver
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- Driver List Table -->
        <h3 class="mt-4">Driver List</h3>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>NIC</th>
                    <th>Phone Number</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="driverTableBody">
                <!-- Dynamic driver list will be populated here by JavaScript -->
            </tbody>
        </table>
    </div>

    <!-- Add Driver Modal -->
    <div class="modal fade" id="addDriverModal" tabindex="-1" aria-labelledby="addDriverModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="addDriverModalLabel">Add New Driver</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addDriverForm" onsubmit="addDriver(event)">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Driver Name</label>
                            <input type="text" id="driverName" name="driverName" class="form-control" placeholder="Enter driver name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Driver NIC</label>
                            <input type="text" id="driverNIC" name="driverNIC" class="form-control" placeholder="Enter driver NIC" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Phone Number</label>
                            <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="Enter phone number" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Address</label>
                            <input type="text" id="address" name="address" class="form-control" placeholder="Enter address" required>
                        </div>
                        <div class="d-flex justify-content-end gap-2">
                            <button type="submit" class="btn btn-success">Add</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
