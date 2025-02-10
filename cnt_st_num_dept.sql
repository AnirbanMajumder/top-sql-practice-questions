-- Create the 'student' table to store student details
CREATE TABLE student (
    student_id NUMBER,       -- Unique ID for each student
    student_name VARCHAR(45), -- Name of the student
    gender VARCHAR(6),       -- Gender of the student (M/F)
    dept_id NUMBER           -- Department ID (foreign key reference to 'department' table)
);

-- Create the 'department' table to store department details
CREATE TABLE department (
    dept_id NUMBER,          -- Unique ID for each department
    dept_name VARCHAR(255)   -- Name of the department
);

-- Insert records into the 'student' table
INSERT INTO student (student_id, student_name, gender, dept_id) 
VALUES 
    (1, 'Jack', 'M', 1),
    (2, 'Jane', 'F', 1),
    (3, 'Mark', 'M', 2);

-- Insert records into the 'department' table
INSERT INTO department (dept_id, dept_name) 
VALUES 
    (1, 'Engineering'),
    (2, 'Science'),
    (3, 'Law');

-- Query to get the department name and the number of students in each department
-- Uses LEFT OUTER JOIN to include departments with no students
SELECT 
    d.dept_name, 
    COUNT(s.student_id) AS student_number 
FROM department d 
LEFT OUTER JOIN student s 
ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY COUNT(s.student_id) DESC, d.dept_name;
