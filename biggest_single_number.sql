-- Create the 'number1' table to store numerical values
CREATE TABLE number1 (
    num NUMBER  -- Column to store numbers
);

-- Insert values into the 'number1' table
INSERT INTO number1 (num) VALUES (8);
INSERT INTO number1 (num) VALUES (8);
INSERT INTO number1 (num) VALUES (3);
INSERT INTO number1 (num) VALUES (3);
INSERT INTO number1 (num) VALUES (1);
INSERT INTO number1 (num) VALUES (4);
INSERT INTO number1 (num) VALUES (5);
INSERT INTO number1 (num) VALUES (6);

-- Query to find the maximum unique number (appears only once) from the table
SELECT MAX(num) 
FROM (
    SELECT num, COUNT(*) 
    FROM number1
    GROUP BY num
    HAVING COUNT(1) = 1  -- Filtering numbers that appear only once
    ORDER BY num DESC     -- Sorting in descending order
);

-- Alternative query to find the maximum unique number 
-- by first sorting based on count and filtering unique occurrences
SELECT MAX(num) 
FROM (
    SELECT num, COUNT(1) AS ct 
    FROM number1
    GROUP BY num
    ORDER BY COUNT(1) DESC  -- Sorting by occurrence count
) 
WHERE ct = 1;  -- Filtering numbers that appear only once

-- Simplified query to get the highest number that appears only once
SELECT MAX(num) 
FROM (
    SELECT num, COUNT(1) 
    FROM number1 
    GROUP BY num 
    HAVING COUNT(1) = 1
);
