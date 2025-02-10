-- Create the 'friend_request' table to store information about friend requests sent by users.
CREATE TABLE friend_request (
    sender_id INT NOT NULL,   -- ID of the user who sends the friend request
    send_to_id INT,           -- ID of the user who receives the friend request
    request_date DATE         -- Date when the request was sent
);

-- Create the 'request_accepted' table to store information about accepted friend requests.
CREATE TABLE request_accepted (
    requester_id INT NOT NULL,  -- ID of the user who made the request
    accepter_id INT,            -- ID of the user who accepted the request
    accept_date DATE            -- Date when the request was accepted
);

-- Insert sample data into the 'friend_request' table
INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES ('1', '2', TO_DATE('2016/06/01','YYYY/MM/DD'));  -- Request from user 1 to user 2 on 2016/06/01

INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES ('1', '3', TO_DATE('2016/06/01','YYYY/MM/DD'));  -- Request from user 1 to user 3 on 2016/06/01

INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES ('1', '4', TO_DATE('2016/06/01','YYYY/MM/DD'));  -- Request from user 1 to user 4 on 2016/06/01

INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES ('2', '3', TO_DATE('2016/06/02','YYYY/MM/DD'));  -- Request from user 2 to user 3 on 2016/06/02

INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES ('3', '4', TO_DATE('2016/06/09','YYYY/MM/DD'));  -- Request from user 3 to user 4 on 2016/06/09

-- Insert sample data into the 'request_accepted' table
INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES ('1', '2', TO_DATE('2016/06/03','YYYY/MM/DD'));  -- User 2 accepted request from user 1 on 2016/06/03

INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES ('1', '3', TO_DATE('2016/06/08','YYYY/MM/DD'));  -- User 3 accepted request from user 1 on 2016/06/08

INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES ('2', '3', TO_DATE('2016/06/08','YYYY/MM/DD'));  -- User 3 accepted request from user 2 on 2016/06/08

INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES ('3', '4', TO_DATE('2016/06/09','YYYY/MM/DD'));  -- User 4 accepted request from user 3 on 2016/06/09

INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES ('3', '4', TO_DATE('2016/06/10','YYYY/MM/DD'));  -- User 4 accepted another request from user 3 on 2016/06/10

-- Calculate the acceptance rate of friend requests
-- The acceptance rate is calculated by dividing the number of accepted requests by the total number of sent requests
SELECT ROUND(NVL(
    (SELECT COUNT(1)   -- Count the distinct pairs of requester and accepter (accepted requests)
    FROM (SELECT DISTINCT requester_id, accepter_id FROM request_accepted)
    ) / 
    (SELECT COUNT(1)   -- Count the distinct pairs of sender and receiver (sent requests)
    FROM (SELECT DISTINCT sender_id, send_to_id FROM friend_request)
    ), 0.00), 2) AS accept_rate  -- Round the result to 2 decimal places
FROM dual;
