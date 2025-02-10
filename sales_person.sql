-- Drop existing tables if they exist to avoid conflicts
DROP TABLE salesperson;
DROP TABLE company;
DROP TABLE orders;

-- Create 'salesperson' table with columns for salesperson information
CREATE TABLE salesperson (
    sales_id NUMBER,                -- Unique identifier for each salesperson
    name VARCHAR(255),               -- Name of the salesperson
    salary NUMBER,                  -- Salary of the salesperson
    commission_rate NUMBER,         -- Commission rate for the salesperson
    hire_date VARCHAR(255)          -- Date of hire for the salesperson
);

-- Create 'company' table with columns for company details
CREATE TABLE company (
    com_id NUMBER,                  -- Unique identifier for each company
    name VARCHAR(255),               -- Name of the company
    city VARCHAR(255)                -- City where the company is located
);

-- Create 'orders' table with columns for order details
CREATE TABLE orders (
    order_id NUMBER,                -- Unique identifier for each order
    date1 VARCHAR(255),             -- Date of the order
    com_id NUMBER,                  -- Company ID associated with the order
    sales_id NUMBER,                -- Salesperson ID who made the sale
    amount NUMBER                   -- Amount of the order
);

-- Insert sample salesperson data
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) 
VALUES ('1', 'John', '100000', '6', '4/1/2006');  -- John with a salary of 100000 and 6% commission

INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) 
VALUES ('2', 'Amy', '12000', '5', '5/1/2010');    -- Amy with a salary of 12000 and 5% commission

INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) 
VALUES ('3', 'Mark', '65000', '12', '12/25/2008'); -- Mark with a salary of 65000 and 12% commission

INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) 
VALUES ('4', 'Pam', '25000', '25', '1/1/2005');    -- Pam with a salary of 25000 and 25% commission

INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) 
VALUES ('5', 'Alex', '5000', '10', '2/3/2007');    -- Alex with a salary of 5000 and 10% commission

-- Insert sample company data
INSERT INTO company (com_id, name, city) 
VALUES ('1', 'RED', 'Boston');      -- RED company located in Boston

INSERT INTO company (com_id, name, city) 
VALUES ('2', 'ORANGE', 'New York'); -- ORANGE company located in New York

INSERT INTO company (com_id, name, city) 
VALUES ('3', 'YELLOW', 'Boston');   -- YELLOW company located in Boston

INSERT INTO company (com_id, name, city) 
VALUES ('4', 'GREEN', 'Austin');    -- GREEN company located in Austin

-- Insert sample order data
INSERT INTO orders (order_id, date1, com_id, sales_id, amount) 
VALUES ('1', '1/1/2014', '3', '4', '10000');  -- Order 1, GREEN company, Pam made the sale

INSERT INTO orders (order_id, date1, com_id, sales_id, amount) 
VALUES ('2', '2/1/2014', '4', '5', '5000');   -- Order 2, GREEN company, Alex made the sale

INSERT INTO orders (order_id, date1, com_id, sales_id, amount) 
VALUES ('3', '3/1/2014', '1', '1', '50000');  -- Order 3, RED company, John made the sale

INSERT INTO orders (order_id, date1, com_id, sales_id, amount) 
VALUES ('4', '4/1/2014', '1', '4', '25000');  -- Order 4, RED company, Pam made the sale

-- Query to find salesperson names who have not made any sales for the 'RED' company
SELECT name 
FROM salesperson
WHERE sales_id NOT IN (
    SELECT sales_id 
    FROM orders 
    WHERE com_id IN (
        SELECT com_id 
        FROM company 
        WHERE name = 'RED'
    )
);

-- Alternative query to find salesperson names who have not made any sales for the 'RED' company
SELECT name 
FROM salesperson
WHERE sales_id NOT IN (
    SELECT o.sales_id 
    FROM orders o
    JOIN company c ON (o.com_id = c.com_id)
    WHERE c.name = 'RED'
);
