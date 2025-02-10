-- Drop the existing tables if they exist to ensure the environment is clean.
DROP TABLE Employee;
DROP TABLE Bonus;

-- Create the Employee table with columns for Employee ID, Name, Supervisor, and Salary.
CREATE TABLE Employee (
    EmpId NUMBER,                -- Employee ID (unique)
    Name VARCHAR(255),            -- Employee Name
    Supervisor NUMBER,           -- Supervisor's Employee ID (nullable for top-level employees)
    Salary NUMBER                -- Employee Salary
);

-- Create the Bonus table with columns for Employee ID and Bonus amount.
CREATE TABLE Bonus (
    EmpId NUMBER,                -- Employee ID (corresponds to Employee table)
    Bonus NUMBER                 -- Bonus amount
);

-- Insert records into the Employee table, associating each employee with their supervisor.
-- Note that supervisor is NULL for top-level employees.
INSERT INTO Employee (EmpId, Name, Supervisor, Salary) 
VALUES ('3', 'Brad', NULL, '4000');  -- Brad has no supervisor (top-level employee)
INSERT INTO Employee (EmpId, Name, Supervisor, Salary) 
VALUES ('1', 'John', '3', '1000');  -- John reports to Brad
INSERT INTO Employee (EmpId, Name, Supervisor, Salary) 
VALUES ('2', 'Dan', '3', '2000');   -- Dan reports to Brad
INSERT INTO Employee (EmpId, Name, Supervisor, Salary) 
VALUES ('4', 'Thomas', '3', '4000');-- Thomas reports to Brad

-- Insert bonus amounts for employees into the Bonus table.
-- Only two employees (Dan and Thomas) have bonuses recorded.
INSERT INTO Bonus (EmpId, Bonus) 
VALUES ('2', '500');  -- Dan's bonus is 500
INSERT INTO Bonus (EmpId, Bonus) 
VALUES ('4', '2000'); -- Thomas' bonus is 2000

-- Query to find employees who either have no bonus (bonus is NULL) or have a bonus less than 1000.
-- The LEFT OUTER JOIN ensures that all employees are included, even if they do not have a bonus record.
SELECT Name, Bonus 
FROM Employee 
LEFT OUTER JOIN Bonus ON (Employee.EmpId = Bonus.EmpId) 
WHERE Bonus IS NULL OR Bonus < 1000;
