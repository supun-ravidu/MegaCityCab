CREATE DATABASE VehicleDB;
USE VehicleDB;

-- Create the Customers table with a password field
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    nic VARCHAR(12) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL   -- Adding password column (hash the password)
);

-- Create the Bookings table
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    car_model VARCHAR(100) NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    drop_location VARCHAR(255) NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);



SELECT * FROM Bookings;


CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(255) UNIQUE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    fare DECIMAL(10, 2) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add new columns to the existing Bookings table
ALTER TABLE Bookings
ADD COLUMN pickup_location VARCHAR(255) NOT NULL,
ADD COLUMN vehicle_type VARCHAR(50) NOT NULL,
ADD COLUMN tax DECIMAL(10, 2) NOT NULL,
ADD COLUMN total_fare DECIMAL(10, 2) NOT NULL,
ADD COLUMN booking_time TIME NOT NULL;













	-- Create Cars table
	CREATE TABLE Cars (
		car_id INT AUTO_INCREMENT PRIMARY KEY,
		car_model VARCHAR(100) NOT NULL,
		car_type VARCHAR(50),
		license_plate VARCHAR(20) UNIQUE NOT NULL,
		year INT,
		status VARCHAR(20) DEFAULT 'Available'
	);


SELECT * FROM Cars;

SELECT license_plate FROM Cars WHERE status = 'Available';


SELECT * FROM Drivers;

SELECT DISTINCT car_type FROM Cars WHERE status = 'Available';


SELECT car_model, license_plate FROM Cars WHERE car_type = 'Luxury' AND status = 'Available';






CREATE TABLE Drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    license_plate VARCHAR(20),  -- Added license_plate for auto association
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (license_plate) REFERENCES Cars(license_plate) ON DELETE SET NULL
);






ALTER TABLE Bookings
ADD COLUMN car_model VARCHAR(100) NOT NULL,
ADD COLUMN car_type VARCHAR(50),
ADD COLUMN car_license_plate VARCHAR(20),
ADD COLUMN driver_name VARCHAR(100),
ADD COLUMN driver_phone VARCHAR(15);

ALTER TABLE Bookings
MODIFY COLUMN car_model VARCHAR(100) DEFAULT NULL,
MODIFY COLUMN car_type VARCHAR(50) DEFAULT NULL,
MODIFY COLUMN car_license_plate VARCHAR(20) DEFAULT NULL,
MODIFY COLUMN driver_name VARCHAR(100) DEFAULT NULL,
MODIFY COLUMN driver_phone VARCHAR(15) DEFAULT NULL;

ALTER TABLE Bookings ADD COLUMN payment_method VARCHAR(50);



SELECT * FROM Bookings WHERE order_number = 'ORD1738322518684'; -- Replace with an actual order number


SELECT * FROM Bookings;




CREATE TABLE UserSettings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    dark_mode BOOLEAN DEFAULT FALSE,
    notifications BOOLEAN DEFAULT TRUE,
    vehicle_preference VARCHAR(50) DEFAULT 'Car',
    pickup_location VARCHAR(255) DEFAULT 'City Center'
);


CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM contact_messages ORDER BY submitted_at DESC;









