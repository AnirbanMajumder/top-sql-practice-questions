-- Create the 'Employee' table with columns for Id, Name, Salary, and DepartmentId
CREATE TABLE Employee (
    Id NUMBER,                 -- Unique identifier for the employee
    Name VARCHAR(255),          -- Name of the employee
    Salary NUMBER,              -- Salary of the employee
    DepartmentId NUMBER        -- Foreign key reference to the Department table
);

-- Create the 'Department' table with columns for Id and Name
CREATE TABLE Department (
    Id NUMBER,                 -- Unique identifier for the department
    Name VARCHAR(255)           -- Name of the department (e.g., 'IT', 'Sales')
);

-- Insert sample employee data into the 'Employee' table
INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('1', 'Joe', '70000', '1');  -- Employee Joe, salary 70000, Department IT

INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('2', 'Henry', '80000', '2');  -- Employee Henry, salary 80000, Department Sales

INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('3', 'Sam', '60000', '2');  -- Employee Sam, salary 60000, Department Sales

INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('4', 'Max', '90000', '1');  -- Employee Max, salary 90000, Department IT

INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('5', 'Janet', '69000', '1');  -- Employee Janet, salary 69000, Department IT

INSERT INTO Employee (Id, Name, Salary, DepartmentId) 
VALUES ('6', 'Randy', '85000', '1');  -- Employee Randy, salary 85000, Department IT

-- Insert sample department data into the 'Department' table
INSERT INTO Department (Id, Name) 
VALUES ('1', 'IT');  -- Department IT

INSERT INTO Department (Id, Name) 
VALUES ('2', 'Sales');  -- Department Sales

-- Query to find the top 3 highest salaries per department, ordered by salary
SELECT a.Department, a.Employee, a.Salary
FROM (
    -- Select department name, employee name, and salary, 
    -- and calculate a ranking based on salary within each department
    SELECT 
        d.name AS Department,              -- Department name
        e.name AS Employee,                 -- Employee name
        e.salary AS Salary,                 -- Employee salary
        RANK() OVER (PARTITION BY e.departmentid ORDER BY e.salary DESC) AS rnk  -- Rank employees within each department by salary
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentid = d.id          -- Join Employee and Department based on department id
) a
WHERE a.rnk <= 3                         -- Filter to include only the top 3 ranked employees per department
ORDER BY a.Department;                    -- Order the result by Department

-- Alternative query to find top salaried employees in each department without using RANK()
SELECT 
    d.name AS Department,                -- Department name
    e1.name AS Employee,                 -- Employee name
    e1.salary AS Salary                  -- Employee salary
FROM Employee e1, Department d
WHERE e1.departmentid = d.id
    AND 3 > (                             -- Subquery to check if there are fewer than 3 employees with a higher salary
        SELECT COUNT(DISTINCT e2.salary)   -- Count distinct salaries greater than the current employee's salary
        FROM Employee e2
        WHERE e2.salary > e1.salary 
            AND e1.departmentid = e2.departmentid  -- Ensure the salary comparison is within the same department
    )
ORDER BY 1, 3 DESC;                      -- Order by Department and Salary (descending order)
