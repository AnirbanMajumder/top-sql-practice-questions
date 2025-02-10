-- Create the 'follow' table with columns for followee (the person being followed) and follower (the person following)
CREATE TABLE follow (
    followee VARCHAR(255),  -- The person who is being followed
    follower VARCHAR(255)   -- The person who is following
);

-- Insert sample data into the 'follow' table
INSERT INTO follow (followee, follower) VALUES ('A', 'B');  -- B follows A
INSERT INTO follow (followee, follower) VALUES ('B', 'C');  -- C follows B
INSERT INTO follow (followee, follower) VALUES ('B', 'D');  -- D follows B
INSERT INTO follow (followee, follower) VALUES ('D', 'E');  -- E follows D

-- Query: Count how many people follow each user who is being followed
SELECT f2.followee AS follower, COUNT(1) AS num  -- Select the follower and the count of people following them
FROM follow f1
INNER JOIN follow f2  -- Join the follow table with itself to find relationships
ON (f1.follower = f2.followee)  -- Where the follower in f1 is following the followee in f2
GROUP BY f2.followee  -- Group by the followee (the person being followed)
ORDER BY f2.followee;  -- Order the results by the followee
