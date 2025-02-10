-- Drop existing tables if they exist
DROP TABLE Trips;
DROP TABLE Users;

-- Create the 'Trips' table to store trip details
CREATE TABLE Trips (
    Id NUMBER,           -- Unique trip identifier
    Client_Id NUMBER,    -- ID of the client who booked the trip
    Driver_Id NUMBER,    -- ID of the driver for the trip
    City_Id NUMBER,      -- ID of the city where the trip took place
    Status VARCHAR(50),  -- Status of the trip (e.g., 'completed', 'cancelled_by_driver')
    Request_at DATE      -- Date the trip was requested
);

-- Create the 'Users' table to store user details (clients and drivers)
CREATE TABLE Users (
    Users_Id NUMBER,     -- Unique user identifier
    Banned VARCHAR(50),  -- Status indicating if the user is banned ('Yes' or 'No')
    Role VARCHAR(50)     -- Role of the user ('client' or 'driver')
);

-- Insert sample trip data into the 'Trips' table
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('1', '1', '10', '1', 'completed', TO_DATE('2013-10-01','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('2', '2', '11', '1', 'cancelled_by_driver', TO_DATE('2013-10-01','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('3', '3', '12', '6', 'completed', TO_DATE('2013-10-01','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('4', '4', '13', '6', 'cancelled_by_client', TO_DATE('2013-10-01','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('5', '1', '10', '1', 'completed', TO_DATE('2013-10-02','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('6', '2', '11', '6', 'completed', TO_DATE('2013-10-02','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('7', '3', '12', '6', 'completed', TO_DATE('2013-10-02','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('8', '2', '12', '12', 'completed', TO_DATE('2013-10-03','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('9', '3', '10', '12', 'completed', TO_DATE('2013-10-03','YYYY-MM-DD'));
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) 
VALUES ('10', '4', '13', '12', 'cancelled_by_driver', TO_DATE('2013-10-03','YYYY-MM-DD'));

-- Insert sample user data into the 'Users' table
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('1', 'No', 'client');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('2', 'Yes', 'client');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('3', 'No', 'client');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('4', 'No', 'client');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('10', 'No', 'driver');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('11', 'No', 'driver');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('12', 'No', 'driver');
INSERT INTO Users (Users_Id, Banned, Role) 
VALUES ('13', 'No', 'driver');

-- Calculate the cancellation rate for each day, excluding banned clients and drivers
SELECT 
    request_at AS Day,  -- Display the request date
    ROUND(
        SUM(
            CASE 
                WHEN status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1  -- Count cancellations
                ELSE 0 
            END
        ) / COUNT(1), 2  -- Calculate the cancellation rate (cancellations / total trips)
    ) AS Cancellation_Rate
FROM Trips
WHERE 
    client_id NOT IN (SELECT users_id FROM Users WHERE banned = 'Yes')  -- Exclude banned clients
    AND driver_id NOT IN (SELECT users_id FROM Users WHERE banned = 'Yes')  -- Exclude banned drivers
GROUP BY request_at  -- Group by the request date to calculate the rate for each day
ORDER BY request_at;  -- Order by the request date
