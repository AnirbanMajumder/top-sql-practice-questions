-- Create the 'point' table with a single column 'x' for storing x-axis coordinates
CREATE TABLE point (
    x NUMBER NOT NULL  -- X-coordinate of the point
);

-- Insert sample data into the 'point' table
INSERT INTO point (x) VALUES ('-1');  -- Point at x = -1
INSERT INTO point (x) VALUES ('0');   -- Point at x = 0
INSERT INTO point (x) VALUES ('2');   -- Point at x = 2

-- Query to find the shortest distance between any two distinct points
SELECT 
    MIN(ABS(x1.x - x2.x)) AS shortest  -- Calculate the absolute difference and find the minimum
FROM 
    point x1, point x2   -- Use a Cartesian join between two instances of the 'point' table
WHERE 
    x1.x != x2.x;        -- Ensure we are comparing distinct points (x1 != x2)
