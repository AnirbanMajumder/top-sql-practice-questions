-- Create the 'point_2d' table to store 2D points with x and y coordinates
CREATE TABLE point_2d (
    x NUMBER NOT NULL,  -- X-coordinate of the point
    y NUMBER NOT NULL   -- Y-coordinate of the point
);

-- Insert sample 2D points into the table
INSERT INTO point_2d (x, y) VALUES ('-1', '-1');  -- Point (-1, -1)
INSERT INTO point_2d (x, y) VALUES ('0', '0');    -- Point (0, 0)
INSERT INTO point_2d (x, y) VALUES ('-1', '-2');  -- Point (-1, -2)

-- Query to find the shortest distance between any two distinct points in the table
SELECT 
    MIN(ROUND(SQRT(POWER(d1.x - d2.x, 2) + POWER(d1.y - d2.y, 2)), 2)) AS shortest  -- Calculate the distance and round to 2 decimal places
FROM 
    point_2d d1  -- Alias 'd1' for the first point
JOIN 
    point_2d d2  -- Alias 'd2' for the second point
    ON (d1.x != d2.x OR d1.y != d2.y);  -- Ensure we are comparing distinct points (d1 != d2)
