-- Create the 'orders' table to store order details
CREATE TABLE orders (
    order_number NUMBER,         -- Unique identifier for each order
    customer_number NUMBER,      -- Unique identifier for each customer
    order_date DATE,             -- Date when the order was placed
    required_date DATE,          -- Date when the order is required to be shipped
    shipped_date DATE,           -- Actual date the order was shipped
    status VARCHAR2(15),         -- Status of the order (e.g., 'Shipped', 'Pending')
    comments VARCHAR2(200)       -- Any additional comments about the order
);

-- Insert sample records into the 'orders' table
INSERT INTO orders (order_number, customer_number) VALUES ('1', '1');  -- Order 1 for Customer 1
INSERT INTO orders (order_number, customer_number) VALUES ('2', '2');  -- Order 2 for Customer 2
INSERT INTO orders (order_number, customer_number) VALUES ('3', '3');  -- Order 3 for Customer 3
INSERT INTO orders (order_number, customer_number) VALUES ('4', '3');  -- Order 4 for Customer 3

-- Query to find customers with the maximum number of orders placed
SELECT customer_number 
FROM orders
GROUP BY customer_number
HAVING COUNT(order_number) = (
    -- Subquery to get the maximum number of orders placed by any customer
    SELECT MAX(numOfOrder) 
    FROM (
        SELECT customer_number, COUNT(order_number) AS numOfOrder 
        FROM orders 
        GROUP BY customer_number
    )
);

-- Alternative query to find customers with the maximum number of orders placed (using count(1))
SELECT customer_number 
FROM orders
GROUP BY customer_number
HAVING COUNT(1) = (
    -- Subquery to get the maximum order count (using count(1) instead of count(order_number))
    SELECT MAX(ct) 
    FROM (
        SELECT customer_number, COUNT(1) AS ct 
        FROM orders
        GROUP BY customer_number
    )
);
