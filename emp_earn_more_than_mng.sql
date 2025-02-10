-- Drop the existing Employee table if it exists, to ensure a clean slate.
DROP TABLE Employee;

-- Create the Employee table with columns for Employee ID, Name, Salary, and Manager ID.
CREATE TABLE Employee (
    Id INT,                      -- Employee ID (unique identifier for each employee)
    Name VARCHAR(255),            -- Employee Name
    Salary INT,                   -- Employee Salary
    ManagerId INT                -- Manager ID (ID of the manager, NULL if top-level)
);

-- Insert records into the Employee table with sample data.
-- The 'ManagerId' refers to the ID of the manager (NULL if the employee has no manager).
INSERT INTO Employee (Id, Name, Salary, ManagerId) 
VALUES ('1', 'Joe', '70000', '3');   -- Joe reports to Sam (ManagerId = 3)
INSERT INTO Employee (Id, Name, Salary, ManagerId) 
VALUES ('2', 'Henry', '80000', '4'); -- Henry reports to Max (ManagerId = 4)
INSERT INTO Employee (Id, Name, Salary, ManagerId) 
VALUES ('3', 'Sam', '60000', NULL);  -- Sam is a top-level employee (no manager)
INSERT INTO Employee (Id, Name, Salary, ManagerId) 
VALUES ('4', 'Max', '90000', NULL);  -- Max is a top-level employee (no manager)

-- Query to find employees who earn more than their managers.
-- This query compares the salary of employees to their managers based on the ManagerId.
SELECT
    a.Name AS 'Employee'   -- Select the employee's name
FROM
    Employee AS a,         -- Alias 'a' for the Employee table representing employees
    Employee AS b          -- Alias 'b' for the Employee table representing managers
WHERE
    a.ManagerId = b.Id     -- Match employees with their managers (ManagerId = Manager's Id)
    AND a.Salary > b.Salary; -- Only include employees who earn more than their managers
