-- Create the 'Candidate' table to store candidate information
CREATE TABLE Candidate (
    id NUMBER,                -- Unique candidate identifier
    Name VARCHAR(255)         -- Candidate's name
);

-- Create the 'Vote' table to store voting records
CREATE TABLE Vote (
    id NUMBER,                -- Unique vote identifier
    CandidateId NUMBER       -- Candidate ID who received the vote
);

-- Insert sample candidates into the 'Candidate' table
INSERT INTO Candidate(id, Name) 
VALUES('1', 'A');
INSERT INTO Candidate(id, Name) 
VALUES('2', 'B');
INSERT INTO Candidate(id, Name) 
VALUES('3', 'C');
INSERT INTO Candidate(id, Name) 
VALUES('4', 'D');
INSERT INTO Candidate(id, Name) 
VALUES('5', 'E');

-- Insert sample votes into the 'Vote' table
INSERT INTO Vote(id, CandidateId) 
VALUES('1', '2');   -- Voter 1 voted for Candidate 'B'
INSERT INTO Vote(id, CandidateId) 
VALUES('2', '4');   -- Voter 2 voted for Candidate 'D'
INSERT INTO Vote(id, CandidateId) 
VALUES('3', '3');   -- Voter 3 voted for Candidate 'C'
INSERT INTO Vote(id, CandidateId) 
VALUES('4', '2');   -- Voter 4 voted for Candidate 'B'
INSERT INTO Vote(id, CandidateId) 
VALUES('5', '5');   -- Voter 5 voted for Candidate 'E'

-- Query to find the candidate with the least votes (first in alphabetical order in case of a tie)
SELECT name 
FROM (
    SELECT name, COUNT(1) AS ct   -- Count the number of votes for each candidate
    FROM Candidate c 
    INNER JOIN Vote v 
    ON (c.id = v.candidateid)    -- Join candidates with their votes based on the candidate ID
    GROUP BY name                -- Group the results by candidate name
    ORDER BY name                -- Order by candidate name alphabetically
) 
WHERE ROWNUM = 1;                 -- Return only the first row (the candidate with the least votes)
