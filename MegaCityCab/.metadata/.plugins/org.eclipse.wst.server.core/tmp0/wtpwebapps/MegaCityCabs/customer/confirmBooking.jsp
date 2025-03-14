<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Booking</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #000;
            color: #fff;
        }
        .card-custom {
            background-color: #ffcc00;
            color: #000;
            border-radius: 10px;
            padding: 30px;
        }
        button {
            background-color: #000;
            color: #ffcc00;
            border: 2px solid #ffcc00;
            padding: 10px 20px;
            font-size: 1.2rem;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div id="navBar"></div>
    
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="card card-custom text-center">
            <h1 class="mb-4">Your Booking Details</h1>
            <p id="bill"></p>
            <p id="pickup"></p>
            <p id="drop"></p>
            <p id="vehicleType"></p>
            <p id="date"></p>
            <p id="time"></p>
            <div class="mt-4">
                <button onclick="confirmBooking()">Confirm Booking</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const params = new URLSearchParams(window.location.search);
            const bookingDetails = {
                bill: params.get("bill") || localStorage.getItem("bill"),
                pickup: params.get("pickup") || localStorage.getItem("pickup"),
                drop: params.get("drop") || localStorage.getItem("drop"),
                vehicleType: params.get("vehicleType") || localStorage.getItem("vehicleType"),
                date: params.get("date") || localStorage.getItem("date"),
                time: params.get("time") || localStorage.getItem("time")
            };

            document.getElementById("bill").textContent = `Your total bill is: ${bookingDetails.bill} LKR`;
            document.getElementById("pickup").textContent = `Pickup Location: ${bookingDetails.pickup}`;
            document.getElementById("drop").textContent = `Drop Location: ${bookingDetails.drop}`;
            document.getElementById("vehicleType").textContent = `Selected Vehicle: ${bookingDetails.vehicleType}`;
            document.getElementById("date").textContent = `Date: ${bookingDetails.date}`;
            document.getElementById("time").textContent = `Time: ${bookingDetails.time}`;
        });

        function confirmBooking() {
            const bookingData = {
                pickup: document.getElementById("pickup").textContent.split(": ")[1],
                drop: document.getElementById("drop").textContent.split(": ")[1],
                vehicleType: document.getElementById("vehicleType").textContent.split(": ")[1],
                date: document.getElementById("date").textContent.split(": ")[1],
                time: document.getElementById("time").textContent.split(": ")[1],
                bill: document.getElementById("bill").textContent.split(": ")[1].split(" LKR")[0],
                vehicleID: 0,
                driverID: 0,
                bookingStatus: "Pending"
            };
            
            fetch("/ConfirmBooking", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(bookingData)
            })
            .then(response => response.json())
            .then(data => {
                alert("Booking Confirmed!");
                window.location.href = "/booking-success";
            })
            .catch(error => console.error("Error:", error));
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
