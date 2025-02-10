-- Create the 'Scores' table to store student or participant scores
CREATE TABLE Scores (
    Id INT,                  -- Unique identifier for each record
    Score DECIMAL(3,2)       -- Score value (with two decimal places)
);

-- Insert sample score data into the 'Scores' table
INSERT INTO Scores (Id, Score) VALUES ('1', '3.5');  -- Record for ID 1 with score 3.5
INSERT INTO Scores (Id, Score) VALUES ('2', '3.65'); -- Record for ID 2 with score 3.65
INSERT INTO Scores (Id, Score) VALUES ('3', '4.0');  -- Record for ID 3 with score 4.0
INSERT INTO Scores (Id, Score) VALUES ('4', '3.85'); -- Record for ID 4 with score 3.85
INSERT INTO Scores (Id, Score) VALUES ('5', '4.0');  -- Record for ID 5 with score 4.0
INSERT INTO Scores (Id, Score) VALUES ('6', '3.65'); -- Record for ID 6 with score 3.65

-- Query to retrieve scores and their corresponding ranks using DENSE_RANK
SELECT 
    TO_NUMBER(Score) "Score",                              -- Convert the score to a number
    DENSE_RANK() OVER (ORDER BY TO_NUMBER(Score) DESC) "Rank" -- Assign a dense rank based on descending score order
FROM Scores;

-- Alternative method to calculate ranks, using subquery to count distinct scores greater than each score
SELECT 
    s1.Score AS Score, 
    (SELECT COUNT(DISTINCT S2.Score) 
     FROM Scores S2 
     WHERE S2.Score > S1.Score) + 1 AS rnk  -- Count the number of distinct scores greater than s1.Score and add 1
FROM Scores s1
ORDER BY rnk;  -- Order the results by rank
