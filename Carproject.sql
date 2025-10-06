
-- Create Database
CREATE DATABASE ERD_CAR2;
GO
USE ERD_CAR2;
GO

-- =====================
-- 1. CREATE TABLES
-- =====================

CREATE TABLE Car (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    Model VARCHAR(100) NOT NULL,
    Brand VARCHAR(100) NOT NULL,
    Year INT NOT NULL,
    PricePerDay DECIMAL(10,2) NOT NULL,
    RegistrationNo VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CarID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    Method VARCHAR(50) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Insurance (
    InsuranceID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT NOT NULL,
    Provider VARCHAR(100) NOT NULL,
    PolicyNumber VARCHAR(50) UNIQUE NOT NULL,
    ExpiryDate DATE NOT NULL,
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

CREATE TABLE Location (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    LocationName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Reservation (
    ReservationID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CarID INT NOT NULL,
    LocationID INT NOT NULL,
    ReservationDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

CREATE TABLE Maintenance (
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT NOT NULL,
    Description VARCHAR(200) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    MaintenanceDate DATE NOT NULL,
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

-- =====================
-- 2. INSERT DATA (CREATE)
-- =====================

-- Car
INSERT INTO Car (Model, Brand, Year, PricePerDay, RegistrationNo) VALUES
('Corolla', 'Toyota', 2020, 50.00, 'KCA123A'),
('Civic', 'Honda', 2019, 45.00, 'KCB456B'),
('Mazda3', 'Mazda', 2021, 55.00, 'KCC789C'),
('Camry', 'Toyota', 2022, 60.00, 'KCD101D'),
('Accord', 'Honda', 2020, 65.00, 'KCE202E');

-- Customer
INSERT INTO Customer (FirstName, LastName, Phone, Email) VALUES
('John', 'Doe', '0712345678', 'john@example.com'),
('Jane', 'Smith', '0723456789', 'jane@example.com'),
('Mike', 'Brown', '0734567890', 'mike@example.com'),
('Sara', 'Wilson', '0745678901', 'sara@example.com'),
('Paul', 'Adams', '0756789012', 'paul@example.com');

-- Booking
INSERT INTO Booking (CustomerID, CarID, StartDate, EndDate) VALUES
(1, 1, '2025-10-01', '2025-10-05'),
(2, 2, '2025-09-25', '2025-09-30'),
(3, 3, '2025-10-03', '2025-10-07'),
(4, 4, '2025-10-10', '2025-10-15'),
(5, 5, '2025-09-20', '2025-09-25');

-- Payment
INSERT INTO Payment (BookingID, Amount, PaymentDate, Method) VALUES
(1, 250.00, '2025-10-01', 'Credit Card'),
(2, 225.00, '2025-09-25', 'Cash'),
(3, 275.00, '2025-10-03', 'Mobile Money'),
(4, 300.00, '2025-10-10', 'Bank Transfer'),
(5, 325.00, '2025-09-20', 'Credit Card');

-- Insurance
INSERT INTO Insurance (CarID, Provider, PolicyNumber, ExpiryDate) VALUES
(1, 'APA Insurance', 'POL123', '2026-01-01'),
(2, 'Britam', 'POL456', '2026-02-15'),
(3, 'Jubilee', 'POL789', '2026-03-20'),
(4, 'AAR Insurance', 'POL101', '2026-04-10'),
(5, 'Madison', 'POL202', '2026-05-05');

-- Location
INSERT INTO Location (LocationName, Address) VALUES
('Nairobi Branch', 'Moi Avenue, Nairobi'),
('Mombasa Branch', 'Nkrumah Road, Mombasa'),
('Kisumu Branch', 'Oginga Odinga Street, Kisumu'),
('Nakuru Branch', 'Kenyatta Avenue, Nakuru'),
('Eldoret Branch', 'Uganda Road, Eldoret');

-- Reservation
INSERT INTO Reservation (CustomerID, CarID, LocationID, ReservationDate) VALUES
(1, 1, 1, '2025-09-15'),
(2, 2, 2, '2025-09-18'),
(3, 3, 3, '2025-09-20'),
(4, 4, 4, '2025-09-22'),
(5, 5, 5, '2025-09-25');

-- Maintenance
INSERT INTO Maintenance (CarID, Description, Cost, MaintenanceDate) VALUES
(1, 'Oil Change', 30.00, '2025-08-01'),
(2, 'Brake Replacement', 150.00, '2025-08-05'),
(3, 'Tire Rotation', 40.00, '2025-08-10'),
(4, 'Battery Replacement', 120.00, '2025-08-12'),
(5, 'Engine Service', 300.00, '2025-08-20');

-- =====================
-- 3. READ (SELECT QUERIES)
-- =====================
SELECT * FROM Car;
SELECT * FROM Customer;
SELECT * FROM Booking;
SELECT * FROM Payment;
SELECT * FROM Insurance;
SELECT * FROM Location;
SELECT * FROM Reservation;
SELECT * FROM Maintenance;

-- Example joins
SELECT c.FirstName, c.LastName, b.BookingID, car.Model, car.Brand, b.StartDate, b.EndDate
FROM Booking b
JOIN Customer c ON b.CustomerID = c.CustomerID
JOIN Car car ON b.CarID = car.CarID;

-- 4. UPDATE (MODIFY DATA)
UPDATE Car
SET PricePerDay = 70.00
WHERE CarID = 5;

UPDATE Customer
SET Phone = '0799999999'
WHERE CustomerID = 3;

-- 5. DELETE (REMOVE DATA)
DELETE FROM Maintenance
WHERE MaintenanceID = 5;

DELETE FROM Reservation
WHERE ReservationID = 5;
