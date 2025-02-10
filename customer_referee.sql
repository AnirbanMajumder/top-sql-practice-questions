-- Drop the 'customer' table if it exists to avoid conflicts
DROP TABLE IF EXISTS customer;

-- Create the 'customer' table to store customer details
CREATE TABLE customer (
    id NUMBER,              -- Unique identifier for each customer
    name VARCHAR(25),       -- Name of the customer
    referee_id NUMBER      -- Referee's customer id (self-referencing foreign key)
);

-- Insert customer records into the 'customer' table
INSERT INTO customer (id, name, referee_id) VALUES (1, 'Will', NULL);   -- Customer 1: Will has no referee
INSERT INTO customer (id, name, referee_id) VALUES (2, 'Jane', NULL);   -- Customer 2: Jane has no referee
INSERT INTO customer (id, name, referee_id) VALUES (3, 'Alex', 2);     -- Customer 3: Alex referred by Jane
INSERT INTO customer (id, name, referee_id) VALUES (4, 'Bill', NULL);   -- Customer 4: Bill has no referee
INSERT INTO customer (id, name, referee_id) VALUES (5, 'Zack', 1);     -- Customer 5: Zack referred by Will
INSERT INTO customer (id, name, referee_id) VALUES (6, 'Mark', 2);     -- Customer 6: Mark referred by Jane

-- Query to select customers who are either not referred by 'Jane' (referee_id = 2) 
-- or do not have any referee (referee_id is NULL)
SELECT name 
FROM customer 
WHERE referee_id <> 2 OR referee_id IS NULL;
