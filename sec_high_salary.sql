-- Create the 'Employee' table with columns for Id (employee ID) and Salary (employee salary)
CREATE TABLE Employee (
    Id INT,              -- Employee ID
    Salary INT           -- Employee Salary
);

-- Insert sample data into the 'Employee' table
INSERT INTO Employee (Id, Salary) VALUES ('1', '100');  -- Employee 1 with salary 100
INSERT INTO Employee (Id, Salary) VALUES ('2', '200');  -- Employee 2 with salary 200
INSERT INTO Employee (Id, Salary) VALUES ('3', '300');  -- Employee 3 with salary 300

-- Query 1: Get the second-highest salary by excluding the maximum salary from the list
SELECT MAX(salary) 
FROM Employee
WHERE salary NOT IN (SELECT MAX(salary) FROM Employee);  -- Exclude the highest salary to get the second highest

-- Query 2: Get the second-highest salary by comparing with the maximum salary
SELECT MAX(salary) 
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);  -- Get the maximum salary that is less than the highest salary

-- Query 3: Use ranking to find the second-highest salary
SELECT salary 
FROM (
    -- Apply ranking to the salaries in descending order
    SELECT salary, RANK() OVER(ORDER BY salary DESC) AS rnk 
    FROM Employee
) 
WHERE rnk = 2;  -- Select the salary with rank 2, which corresponds to the second-highest salary
