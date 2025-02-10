-- Create the 'Logs' table to store numeric log information
CREATE TABLE Logs (
    Id1 NUMBER,   -- Unique log identifier
    Num1 NUMBER   -- Numeric value associated with each log entry
);

-- Insert records into the 'Logs' table
INSERT INTO Logs (Id1, Num1) VALUES (1, 1);  -- Log 1 with value 1
INSERT INTO Logs (Id1, Num1) VALUES (2, 1);  -- Log 2 with value 1
INSERT INTO Logs (Id1, Num1) VALUES (3, 1);  -- Log 3 with value 1
INSERT INTO Logs (Id1, Num1) VALUES (4, 2);  -- Log 4 with value 2
INSERT INTO Logs (Id1, Num1) VALUES (5, 1);  -- Log 5 with value 1
INSERT INTO Logs (Id1, Num1) VALUES (6, 2);  -- Log 6 with value 2
INSERT INTO Logs (Id1, Num1) VALUES (7, 2);  -- Log 7 with value 2

-- Query to find three consecutive logs with the same numeric value
SELECT 
    t1.Num1 AS ConsecutiveNums 
FROM Logs t1, Logs t2, Logs t3 
WHERE 
    t1.Id1 = t2.Id1 - 1  -- t1 is one ID smaller than t2
    AND t2.Id1 = t3.Id1 - 1  -- t2 is one ID smaller than t3
    AND t1.Num1 = t2.Num1  -- All three logs must have the same 'Num1' value
    AND t2.Num1 = t3.Num1;  -- Ensures 'Num1' values of t2 and t3 are equal to t1's 'Num1'
