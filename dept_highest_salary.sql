-- Create the Employee table with columns: Id, Name, Salary, and DepartmentId
CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(255),
    Salary INT,
    DepartmentId INT
);

-- Create the Department table with columns: Id and Name
CREATE TABLE Department (
    Id INT,
    Name VARCHAR(255)
);

-- Insert sample data into the Employee table
INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('1', 'Joe', '70000', '1');
INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('2', 'Henry', '80000', '2');
INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('3', 'Sam', '60000', '2');
INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('4', 'Max', '90000', '1');

-- Insert sample data into the Department table
INSERT INTO Department (Id, Name) 
VALUES ('1', 'IT');
INSERT INTO Department (Id, Name) 
VALUES ('2', 'Sales');

-- Query to get the highest salaried employee from each department
-- It uses DENSE_RANK to rank employees by salary within each department
SELECT * 
FROM (
    SELECT 
        d1.Name AS dept,         -- Department Name
        e1.Name AS employee,     -- Employee Name
        e1.Salary,               -- Employee Salary
        DENSE_RANK() OVER (PARTITION BY d1.name ORDER BY e1.salary DESC) AS rnk -- Rank employees by salary within each department
    FROM Employee e1 
    JOIN Department d1 ON (e1.departmentid = d1.id)  -- Join Employee and Department tables
) 
WHERE rnk = 1;  -- Select only the top-ranked (highest salary) employee in each department

-- Alternative query to get the highest salaried employee from each department
-- This query uses a subquery to find the maximum salary in each department
SELECT 
    d.name AS Department,  -- Department Name
    e1.name AS Employee,   -- Employee Name
    e1.salary AS Salary    -- Employee Salary
FROM employee e1
JOIN department d ON e1.departmentid = d.id  -- Join Employee and Department tables
WHERE e1.salary = (
    SELECT MAX(e2.salary)  -- Subquery to find the maximum salary within each department
    FROM employee e2
    WHERE e2.departmentid = d.id
);
