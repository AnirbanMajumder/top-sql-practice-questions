-- Drop the Employee table if it exists
DROP TABLE Employee;

-- Create the Employee table with columns for Id, Name, Department, and ManagerId
CREATE TABLE Employee (
    Id INT,                       -- Employee's unique ID
    Name VARCHAR(255),             -- Employee's name
    Department VARCHAR(255),       -- Department the employee works in
    ManagerId INT                  -- Manager's ID (NULL for top-level managers)
);

-- Insert sample data into the Employee table
INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES ('101', 'John', 'A', NULL);  -- John is a manager with no manager (top-level)

INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES ('102', 'Dan', 'A', '101');  -- Dan reports to John

INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES ('103', 'James', 'A', '101');  -- James reports to John

INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES ('104', 'Amy', 'A', '101');  -- Amy reports to John

INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES ('105', 'Anne', 'A', '101');  -- Anne reports to John

INSERT INTO Employee (Id, Name, Department, ManagerId) 
VALUES ('106', 'Ron', 'B', '101');  -- Ron reports to John

-- Query to find managers who have 5 or more people reporting to them
SELECT temp.name AS Name 
FROM (
    SELECT e2.name AS Name, count(e2.id) AS num_reports 
    FROM Employee e1 
    JOIN Employee e2 ON (e1.managerid = e2.id)  -- Join employees with their managers
    GROUP BY e2.name  -- Group by manager name
    HAVING count(e2.name) >= 5  -- Only include managers with 5 or more reports
) temp;
