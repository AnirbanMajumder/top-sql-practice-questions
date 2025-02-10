-- Create the 'courses' table to store student enrollments in different classes
CREATE TABLE courses (
    student VARCHAR(255),  -- Student name
    class VARCHAR(255)     -- Class name
);

-- Insert student-class enrollment records
INSERT INTO courses (student, class) VALUES ('A', 'Math');
INSERT INTO courses (student, class) VALUES ('B', 'English');
INSERT INTO courses (student, class) VALUES ('C', 'Math');
INSERT INTO courses (student, class) VALUES ('D', 'Biology');
INSERT INTO courses (student, class) VALUES ('E', 'Math');
INSERT INTO courses (student, class) VALUES ('F', 'Computer');
INSERT INTO courses (student, class) VALUES ('G', 'Math');
INSERT INTO courses (student, class) VALUES ('H', 'Math');
INSERT INTO courses (student, class) VALUES ('I', 'Math');

-- Query to find classes that have at least 5 distinct students enrolled
SELECT class 
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;
