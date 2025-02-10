-- Create the 'triangle' table with three columns representing the sides of a triangle
CREATE TABLE triangle (
    x NUMBER,  -- Side x of the triangle
    y NUMBER,  -- Side y of the triangle
    z NUMBER   -- Side z of the triangle
);

-- Insert sample data representing the sides of two triangles
INSERT INTO triangle (x, y, z) 
VALUES (13, 15, 30);  -- Triangle 1 with sides 13, 15, and 30

INSERT INTO triangle (x, y, z) 
VALUES (10, 20, 15);  -- Triangle 2 with sides 10, 20, and 15

-- Query to check if the sides form a valid triangle
SELECT 
    x, 
    y, 
    z, 
    CASE 
        -- Check if the sum of any two sides is greater than the third side (triangle inequality theorem)
        WHEN ((x + y > z) AND (x + z > y) AND (z + y > x)) THEN 'Yes'   -- Valid triangle
        ELSE 'No'  -- Invalid triangle
    END AS triangle  -- Label the result as either 'Yes' or 'No'
FROM triangle;
