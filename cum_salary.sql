-- Create the 'Employee' table to store employee salary records
-- Using 'IF NOT EXISTS' to avoid errors if the table already exists
CREATE TABLE IF NOT EXISTS Employee (
    Id INT,      -- Employee ID
    Month INT,   -- Month of the salary record
    Salary INT   -- Employee's salary for that month
);

-- Truncate the 'Employee' table to remove all records (reset the table)
TRUNCATE TABLE Employee;

-- Insert salary records for various employees across different months
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 1, 20);  -- Employee 1, Month 1, Salary 20
INSERT INTO Employee (Id, Month, Salary) VALUES (2, 1, 20);  -- Employee 2, Month 1, Salary 20
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 2, 30);  -- Employee 1, Month 2, Salary 30
INSERT INTO Employee (Id, Month, Salary) VALUES (2, 2, 30);  -- Employee 2, Month 2, Salary 30
INSERT INTO Employee (Id, Month, Salary) VALUES (3, 2, 40);  -- Employee 3, Month 2, Salary 40
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 3, 40);  -- Employee 1, Month 3, Salary 40
INSERT INTO Employee (Id, Month, Salary) VALUES (3, 3, 60);  -- Employee 3, Month 3, Salary 60
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 4, 60);  -- Employee 1, Month 4, Salary 60
INSERT INTO Employee (Id, Month, Salary) VALUES (3, 4, 70);  -- Employee 3, Month 4, Salary 70

-- Create a temporary 'max_month' table to get the latest month for each employee
WITH max_month AS (
    SELECT 
        id, 
        MAX(month) AS max_month   -- Find the latest month for each employee
    FROM Employee 
    GROUP BY id
)

-- Query to calculate cumulative salary for each employee excluding their latest month
SELECT 
    e.id AS Id, 
    e.month AS Month, 
    SUM(e.salary) OVER (PARTITION BY e.id ORDER BY e.month) AS cum_salary  -- Cumulative salary calculation
FROM Employee e
WHERE e.month NOT IN (
    SELECT max_month 
    FROM max_month 
    WHERE max_month.id = e.id  -- Exclude the latest month for each employee
)
ORDER BY e.id, e.month DESC;

-- Another approach to calculate cumulative salary, excluding the latest month
SELECT 
    v.id AS Id, 
    v.month AS Month, 
    v.Salary 
FROM (
    SELECT 
        e.*, 
        SUM(e.salary) OVER (PARTITION BY e.id ORDER BY e.month) AS Salary  -- Cumulative salary calculation
    FROM employee e
) v
WHERE v.month NOT IN (
    SELECT e1.id, MAX(e1.month)  -- Exclude the latest month for each employee
    FROM employee e1 
    WHERE v.id = e1.id 
    GROUP BY e1.id
)
ORDER BY v.id, v.month DESC;

-- Query to rank and exclude the highest salary month for each employee
SELECT 
    id, 
    month, 
    salary 
FROM (
    SELECT 
        id, 
        month, 
        salary AS sal, 
        SUM(salary) OVER (PARTITION BY id ORDER BY salary) AS salary,  -- Cumulative salary calculation
        RANK() OVER (PARTITION BY id ORDER BY month DESC) AS rnk  -- Rank based on the latest month
    FROM Employee
)
WHERE rnk <> 1  -- Exclude the latest month (rank 1)
ORDER BY id, month DESC;
