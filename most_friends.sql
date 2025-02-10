-- Create the 'request_accepted' table to store the details of friend requests that were accepted
CREATE TABLE request_accepted (
    requester_id INT NOT NULL,  -- ID of the person who sent the request
    accepter_id INT NULL,       -- ID of the person who accepted the request
    accept_date DATE NULL       -- The date when the request was accepted
);

-- Insert data into the 'request_accepted' table for various request acceptance scenarios
INSERT INTO request_accepted (requester_id, accepter_id, accept_date) 
VALUES ('1', '2', TO_DATE('2016/06/03','YYYY/MM/DD'));  -- Request from 1 to 2 accepted on 2016/06/03

INSERT INTO request_accepted (requester_id, accepter_id, accept_date) 
VALUES ('1', '3', TO_DATE('2016/06/08','YYYY/MM/DD'));  -- Request from 1 to 3 accepted on 2016/06/08

INSERT INTO request_accepted (requester_id, accepter_id, accept_date) 
VALUES ('2', '3', TO_DATE('2016/06/08','YYYY/MM/DD'));  -- Request from 2 to 3 accepted on 2016/06/08

INSERT INTO request_accepted (requester_id, accepter_id, accept_date) 
VALUES ('3', '4', TO_DATE('2016/06/09','YYYY/MM/DD'));  -- Request from 3 to 4 accepted on 2016/06/09

-- Query to find the ID that appears the most in both requester and accepter columns
SELECT ids, ct
FROM (
    SELECT ids, COUNT(1) AS ct  -- Count the occurrences of each ID
    FROM (
        -- Combine requester_id and accepter_id into a single list of IDs
        SELECT requester_id AS ids FROM request_accepted
        UNION ALL
        SELECT accepter_id AS ids FROM request_accepted
    )
    GROUP BY ids  -- Group by the ID to get the total count
    ORDER BY COUNT(1) DESC  -- Order by the count in descending order to get the most frequent ID at the top
)
WHERE ROWNUM = 1;  -- Return only the ID with the highest count
