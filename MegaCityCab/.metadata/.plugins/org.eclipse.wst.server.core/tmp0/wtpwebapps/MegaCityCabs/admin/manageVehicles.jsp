<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Vehicles</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Fetch all vehicles from the backend
        function fetchVehicles() {
            fetch('/api/vehicles')
                .then(response => response.json())
                .then(vehicles => {
                    const vehicleTableBody = document.getElementById('vehicleTableBody');
                    vehicleTableBody.innerHTML = ''; // Clear the table body
                    vehicles.forEach(vehicle => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${vehicle.vehicleID}</td>
                            <td>${vehicle.vehicleName}</td>
                            <td>${vehicle.model}</td>
                            <td>${vehicle.brand}</td>
                            <td>${vehicle.year}</td>
                            <td>${vehicle.registrationNumber}</td>
                            <td>${vehicle.seatingCapacity}</td>
                            <td>${vehicle.fuelType}</td>
                            <td>${vehicle.ratePerDay}</td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="deleteVehicle(${vehicle.vehicleID})">❌</button>
                            </td>
                        `;
                        vehicleTableBody.appendChild(row);
                    });
                });
        }

        // Handle vehicle deletion
        function deleteVehicle(vehicleID) {
            fetch(`/api/vehicles/${vehicleID}`, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    alert('Vehicle deleted successfully!');
                    fetchVehicles(); // Refresh the vehicle list
                } else {
                    alert('Error deleting vehicle');
                }
            });
        }

        // Handle adding a new vehicle
        function addVehicle(event) {
            event.preventDefault();
            const vehicleName = document.getElementById('vehicleName').value;
            const model = document.getElementById('model').value;
            const brand = document.getElementById('brand').value;
            const year = document.getElementById('year').value;
            const registrationNumber = document.getElementById('registrationNumber').value;
            const seatingCapacity = document.getElementById('seatingCapacity').value;
            const fuelType = document.getElementById('fuelType').value;
            const ratePerDay = document.getElementById('ratePerDay').value;

            const vehicleData = { vehicleName, model, brand, year, registrationNumber, seatingCapacity, fuelType, ratePerDay };

            fetch('/api/vehicles', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(vehicleData)
            })
            .then(response => response.json())
            .then(() => {
                alert('Vehicle added successfully!');
                fetchVehicles(); // Refresh the vehicle list
                $('#addVehicleModal').modal('hide'); // Close modal
            })
            .catch(() => alert('Error adding vehicle'));
        }

        // Initialize the page by fetching the vehicles
        window.onload = fetchVehicles;
    </script>
</head>
<body>
    <!-- Include navigation bar here -->
    <!-- Example: <nav> ... </nav> -->

    <div class="container mt-4">
        <h1 class="mb-4 text-center">Manage Vehicles</h1>

        <!-- Actions Table -->
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <td class="text-center">
                        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#addVehicleModal">
                            Add Vehicle
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- Vehicle List Table -->
        <h3 class="mt-4">Vehicle List</h3>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Vehicle Name</th>
                    <th>Model</th>
                    <th>Brand</th>
                    <th>Year</th>
                    <th>Registration Number</th>
                    <th>Seating Capacity</th>
                    <th>Fuel Type</th>
                    <th>Rate Per Day</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="vehicleTableBody">
                <!-- Dynamic vehicle list will be populated here by JavaScript -->
            </tbody>
        </table>
    </div>

    <!-- Add Vehicle Modal -->
    <div class="modal fade" id="addVehicleModal" tabindex="-1" aria-labelledby="addVehicleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="addVehicleModalLabel">Add New Vehicle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addVehicleForm" onsubmit="addVehicle(event)">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Vehicle Name</label>
                            <select id="vehicleName" class="form-control" required>
                                <option value="" disabled selected>Select a vehicle</option>
                                <option value="Alto">Alto</option>
                                <option value="WagonR">WagonR</option>
                                <option value="KDH">KDH</option>
                                <option value="Prius">Prius</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Model</label>
                            <input type="text" id="model" class="form-control" placeholder="Enter model" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Brand</label>
                            <input type="text" id="brand" class="form-control" placeholder="Enter brand" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Year</label>
                            <input type="text" id="year" class="form-control" placeholder="Enter year" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Registration Number</label>
                            <input type="text" id="registrationNumber" class="form-control" placeholder="Enter registration number" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Seating Capacity</label>
                            <input type="number" id="seatingCapacity" class="form-control" placeholder="Enter seating capacity" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Fuel Type</label>
                            <input type="text" id="fuelType" class="form-control" placeholder="Enter fuel type" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Rate Per Day</label>
                            <input type="number" id="ratePerDay" class="form-control" placeholder="Enter rate per day" required>
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
