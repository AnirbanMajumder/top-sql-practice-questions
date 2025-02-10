-- Create the Numbers table with columns for Number1 and Frequency
CREATE TABLE Numbers (
    Number1 NUMBER,           -- The number value
    Frequency NUMBER          -- The frequency (count) of each number
);

-- Insert sample data into the Numbers table
INSERT INTO Numbers (Number1, Frequency) VALUES ('0', '7');  -- Number 0 appears 7 times
INSERT INTO Numbers (Number1, Frequency) VALUES ('1', '1');  -- Number 1 appears 1 time
INSERT INTO Numbers (Number1, Frequency) VALUES ('2', '3');  -- Number 2 appears 3 times
INSERT INTO Numbers (Number1, Frequency) VALUES ('3', '1');  -- Number 3 appears 1 time

-- Calculate the median by finding the number that divides the total frequencies into two equal parts
SELECT 
    AVG(n.Number1) AS median  -- Calculate the average of the number(s) that divide the data in half
FROM 
    Numbers n
WHERE 
    n.Frequency >= ABS(
        (SELECT SUM(Frequency) FROM Numbers WHERE Number1 <= n.Number1)  -- Sum frequencies of numbers less than or equal to the current number
        - 
        (SELECT SUM(Frequency) FROM Numbers WHERE Number1 >= n.Number1)   -- Sum frequencies of numbers greater than or equal to the current number
    );
