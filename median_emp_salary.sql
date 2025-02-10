-- Drop the Employee table if it exists
DROP TABLE Employee;

-- Create the Employee table with columns for Id, Company, and Salary
CREATE TABLE Employee (
    Id NUMBER,                  -- Employee's unique ID
    Company VARCHAR(255),        -- Company the employee works for
    Salary NUMBER                -- Employee's salary
);

-- Insert sample data into the Employee table
INSERT INTO Employee (Id, Company, Salary) VALUES (1, 'A', 2341);
INSERT INTO Employee (Id, Company, Salary) VALUES (2, 'A', 341);
INSERT INTO Employee (Id, Company, Salary) VALUES (3, 'A', 15);
INSERT INTO Employee (Id, Company, Salary) VALUES (4, 'A', 15314);
INSERT INTO Employee (Id, Company, Salary) VALUES (5, 'A', 451);
INSERT INTO Employee (Id, Company, Salary) VALUES (6, 'A', 513);
INSERT INTO Employee (Id, Company, Salary) VALUES (7, 'B', 15);
INSERT INTO Employee (Id, Company, Salary) VALUES (8, 'B', 13);
INSERT INTO Employee (Id, Company, Salary) VALUES (9, 'B', 1154);
INSERT INTO Employee (Id, Company, Salary) VALUES (10, 'B', 1345);
INSERT INTO Employee (Id, Company, Salary) VALUES (11, 'B', 1221);
INSERT INTO Employee (Id, Company, Salary) VALUES (12, 'B', 234);
INSERT INTO Employee (Id, Company, Salary) VALUES (13, 'C', 2345);
INSERT INTO Employee (Id, Company, Salary) VALUES (14, 'C', 2645);
INSERT INTO Employee (Id, Company, Salary) VALUES (15, 'C', 2645);
INSERT INTO Employee (Id, Company, Salary) VALUES (16, 'C', 2652);
INSERT INTO Employee (Id, Company, Salary) VALUES (17, 'C', 65);

-- First query: Retrieve employee details along with their rank (row number) within each company
-- It also joins with the count of employees per company
SELECT * 
FROM (
    SELECT 
        e1.id, 
        e1.company, 
        e1.salary, 
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) AS rwnm  -- Assign row numbers within each company ordered by salary
    FROM Employee e1
) a
JOIN (
    SELECT 
        company, 
        COUNT(*) ct  -- Count the number of employees per company
    FROM Employee
    GROUP BY company
) b
ON (a.company = b.company);

-- Second query: Retrieve the middle salary(s) for each company
SELECT 
    c.id, 
    c.company, 
    c.salary 
FROM (
    SELECT 
        id,
        company,
        salary,
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) rno,  -- Row number within each company
        COUNT(*) OVER (PARTITION BY company) cnt  -- Total count of employees in each company
    FROM employee
) c
WHERE c.rno IN (CEIL(c.cnt/2), c.cnt/2 + 1);  -- Get the middle salary (or the two middle ones in case of an even number of employees)
