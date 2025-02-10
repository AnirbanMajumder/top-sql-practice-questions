-- Create a table 'salary' with columns: id, name, sex, and salary
CREATE TABLE salary (
    id NUMBER,            -- ID of the employee (unique identifier)
    name VARCHAR(100),     -- Name of the employee
    sex VARCHAR(1),        -- Sex of the employee (either 'm' for male or 'f' for female)
    salary NUMBER          -- Salary of the employee
);

-- Insert sample data into the 'salary' table
INSERT INTO salary (id, name, sex, salary) VALUES ('1', 'A', 'm', '2500');  -- Employee A, male, salary 2500
INSERT INTO salary (id, name, sex, salary) VALUES ('2', 'B', 'f', '1500');  -- Employee B, female, salary 1500
INSERT INTO salary (id, name, sex, salary) VALUES ('3', 'C', 'm', '5500');  -- Employee C, male, salary 5500
INSERT INTO salary (id, name, sex, salary) VALUES ('4', 'D', 'f', '500');   -- Employee D, female, salary 500

-- Update the 'sex' column for all employees: change male ('m') to female ('f') and female ('f') to male ('m')
UPDATE salary
SET sex = CASE 
            WHEN sex = 'm' THEN 'f'  -- If the employee is male ('m'), change to female ('f')
            ELSE 'm'                 -- If the employee is female ('f'), change to male ('m')
          END;
