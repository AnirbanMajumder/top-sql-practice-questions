-- Create the 'cinema' table to store movie information
CREATE TABLE cinema (
    id INT,                    -- Unique identifier for each movie
    movie VARCHAR(255),         -- Name of the movie
    description VARCHAR(255),   -- Short description of the movie
    rating NUMBER              -- Rating of the movie
);

-- Insert sample data into the 'cinema' table
INSERT INTO cinema (id, movie, description, rating) 
VALUES ('1', 'War', 'great 3D', '8.9');  -- Movie 'War' with rating 8.9 and description 'great 3D'

INSERT INTO cinema (id, movie, description, rating) 
VALUES ('2', 'Science', 'fiction', '8.5');  -- Movie 'Science' with rating 8.5 and description 'fiction'

INSERT INTO cinema (id, movie, description, rating) 
VALUES ('3', 'Irish', 'boring', '6.2');  -- Movie 'Irish' with rating 6.2 and description 'boring'

INSERT INTO cinema (id, movie, description, rating) 
VALUES ('4', 'Ice Song', 'Fantasy', '8.6');  -- Movie 'Ice Song' with rating 8.6 and description 'Fantasy'

INSERT INTO cinema (id, movie, description, rating) 
VALUES ('5', 'House Card', 'Interesting', '9.1');  -- Movie 'House Card' with rating 9.1 and description 'Interesting'

-- Query to retrieve movies based on specific conditions:
SELECT id, movie, description, rating 
FROM cinema
WHERE MOD(id, 2) != 0  -- Filter for movies with an odd id (id % 2 != 0)
  AND description <> 'boring'  -- Exclude movies with description 'boring'
ORDER BY rating DESC;  -- Order the result by rating in descending order
