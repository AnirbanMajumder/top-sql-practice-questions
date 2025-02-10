-- Drop existing tables if they exist to avoid conflicts
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;

-- Create the 'Customers' table to store customer details
CREATE TABLE Customers (
    Id INT,                 -- Unique identifier for each customer
    Name VARCHAR(255)       -- Name of the customer
);

-- Create the 'Orders' table to store order details linked to customers
CREATE TABLE Orders (
    Id INT,                 -- Unique identifier for each order
    CustomerId INT          -- Foreign key referencing the 'Customers' table
);

-- Insert sample customer records into the 'Customers' table
INSERT INTO Customers (Id, Name) VALUES ('1', 'Joe');  -- Customer 1: Joe
INSERT INTO Customers (Id, Name) VALUES ('2', 'Henry');  -- Customer 2: Henry
INSERT INTO Customers (Id, Name) VALUES ('3', 'Sam');  -- Customer 3: Sam
INSERT INTO Customers (Id, Name) VALUES ('4', 'Max');  -- Customer 4: Max

-- Insert sample order records into the 'Orders' table
INSERT INTO Orders (Id, CustomerId) VALUES ('1', '3');  -- Order 1 placed by Customer 3 (Sam)
INSERT INTO Orders (Id, CustomerId) VALUES ('2', '1');  -- Order 2 placed by Customer 1 (Joe)

-- Query to find customers who have not placed any orders
SELECT t1.Name AS Customers  -- Retrieve customer names
FROM Customers t1 
LEFT OUTER JOIN Orders t2 ON t1.Id = t2.CustomerId  -- Left join 'Customers' with 'Orders'
WHERE t2.CustomerId IS NULL;  -- Filter customers with no matching orders

-- Another query using NOT EXISTS to find customers with no orders
SELECT A.Name  -- Retrieve customer names
FROM Customers A
WHERE NOT EXISTS (  -- Check for customers without any orders in the 'Orders' table
    SELECT 1 
    FROM Orders B 
    WHERE A.Id = B.CustomerId
);

-- Another query using LEFT JOIN to find customers who haven't placed any orders
SELECT A.Name  -- Retrieve customer names
FROM Customers A
LEFT JOIN Orders B ON A.Id = B.CustomerId  -- Left join 'Customers' with 'Orders'
WHERE B.CustomerId IS NULL;  -- Filter customers with no matching orders in 'Orders'

-- A similar query using NOT IN to find customers without orders
SELECT A.Name  -- Retrieve customer names
FROM Customers A
WHERE A.Id NOT IN (  -- Check for customers who don't exist in the 'Orders' table
    SELECT B.CustomerId 
    FROM Orders B
);
