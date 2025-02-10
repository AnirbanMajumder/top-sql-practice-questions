-- Drop tables if they already exist to avoid conflicts
DROP TABLE Person;
DROP TABLE Address;

-- Create the 'Person' table to store personal details
CREATE TABLE Person (
    PersonId INT,          -- Unique ID for each person
    FirstName VARCHAR(255), -- First name of the person
    LastName VARCHAR(255)   -- Last name of the person
);

-- Create the 'Address' table to store address details
CREATE TABLE Address (
    AddressId INT,         -- Unique ID for each address entry
    PersonId INT,          -- Foreign key referencing Person(PersonId)
    City VARCHAR(255),     -- City name
    State VARCHAR(255)     -- State name
);

-- Insert data into the 'Person' table
INSERT INTO Person (PersonId, LastName, FirstName) 
VALUES (1, 'Wang', 'Allen');

-- Insert data into the 'Address' table
-- Note: The PersonId here (2) does not exist in the 'Person' table, which may cause issues when joining
INSERT INTO Address (AddressId, PersonId, City, State) 
VALUES (1, 2, 'New York City', 'New York');

-- Query to retrieve FirstName, LastName, City, and State using LEFT JOIN
-- Ensures all persons are included, even if they have no address
SELECT 
    FirstName, 
    LastName, 
    City, 
    State
FROM Person 
LEFT JOIN Address 
ON Person.PersonId = Address.PersonId;
