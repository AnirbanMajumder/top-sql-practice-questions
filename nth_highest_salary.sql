-- Create the 'salary' table to store employee salary information
CREATE TABLE salary (
    id NUMBER,        -- Unique identifier for the employee
    salary NUMBER     -- Salary of the employee
);

-- Insert sample salary data into the 'salary' table
INSERT INTO salary VALUES (1, 100);  -- Employee with ID 1 and salary 100
INSERT INTO salary VALUES (2, 200);  -- Employee with ID 2 and salary 200
INSERT INTO salary VALUES (3, 300);  -- Employee with ID 3 and salary 300

-- Query to retrieve the second highest salary from the 'salary' table
SELECT * 
FROM (
    SELECT salary, ROWNUM AS rwn        -- Select the salary and assign row numbers
    FROM salary
    ORDER BY salary DESC                -- Order the salaries in descending order
)
WHERE rwn = 2;  -- Select the row with the second highest salary (rwn = 2)
