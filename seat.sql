-- Drop the existing 'seat' table if it exists to avoid conflicts
DROP TABLE seat;

-- Create 'seat' table with columns for id (seat number) and student (student name)
CREATE TABLE seat (
    id INT,                         -- Seat number (ID)
    student VARCHAR(255)             -- Name of the student sitting in the seat
);

-- Insert sample data into the 'seat' table
INSERT INTO seat (id, student) VALUES ('1', 'Abbot');    -- Seat 1 occupied by Abbot
INSERT INTO seat (id, student) VALUES ('2', 'Doris');    -- Seat 2 occupied by Doris
INSERT INTO seat (id, student) VALUES ('3', 'Emerson');  -- Seat 3 occupied by Emerson
INSERT INTO seat (id, student) VALUES ('4', 'Green');    -- Seat 4 occupied by Green
INSERT INTO seat (id, student) VALUES ('5', 'Jeames');   -- Seat 5 occupied by Jeames

-- Query to adjust seat numbers based on conditions
SELECT 
    -- Adjust seat numbers as follows:
    -- If the seat ID is even and not the last seat, change it to the previous seat
    -- If the seat ID is odd and not the last seat, change it to the next seat
    -- Otherwise, keep the seat ID unchanged (likely for the last seat)
    CASE 
        WHEN MOD(id, 2) = 0 AND id <> (SELECT COUNT(1) FROM seat) THEN id - 1  -- Even seat, not the last one, go to previous seat
        WHEN MOD(id, 2) <> 0 AND id <> (SELECT COUNT(1) FROM seat) THEN id + 1  -- Odd seat, not the last one, go to next seat
        ELSE id  -- Keep the seat ID unchanged (for the last seat or other conditions)
    END AS id, 
    student 
FROM seat
ORDER BY id;  -- Order the results by seat ID
