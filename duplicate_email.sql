-- Create the Person table if it does not already exist.
-- The table contains two columns: Id (integer) and Email (varchar).
CREATE TABLE IF NOT EXISTS Person (
    Id INT,
    Email VARCHAR(255)
);

-- Truncate the Person table to remove all existing data (if any) before inserting new records.
TRUNCATE TABLE Person;

-- Insert sample data into the Person table.
INSERT INTO Person (Id, Email) VALUES ('1', 'a@b.com');
INSERT INTO Person (Id, Email) VALUES ('2', 'c@d.com');
INSERT INTO Person (Id, Email) VALUES ('3', 'a@b.com');

-- Query to find the emails that appear more than once in the Person table.
-- The 'GROUP BY' clause groups the records by email.
-- The 'HAVING' clause filters the results to only include emails with more than one occurrence.
SELECT email 
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;
