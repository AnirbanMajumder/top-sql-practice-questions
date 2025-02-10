-- Create the 'cinema' table to store seat information and availability
CREATE TABLE cinema (
    seat_id NUMBER,  -- Unique seat identifier
    free NUMBER      -- Indicator for seat availability (1 = free, 0 = occupied)
);

-- Insert records into the 'cinema' table, indicating seat availability
INSERT INTO cinema (seat_id, free) VALUES (1, 1);  -- Seat 1 is free
INSERT INTO cinema (seat_id, free) VALUES (2, 0);  -- Seat 2 is occupied
INSERT INTO cinema (seat_id, free) VALUES (3, 1);  -- Seat 3 is free
INSERT INTO cinema (seat_id, free) VALUES (4, 1);  -- Seat 4 is free
INSERT INTO cinema (seat_id, free) VALUES (5, 1);  -- Seat 5 is free

-- Query to find three consecutive seats that are all free
SELECT 
    c1.seat_id, 
    c2.seat_id, 
    c3.seat_id 
FROM cinema c1, cinema c2, cinema c3 
WHERE 
    c1.seat_id = c2.seat_id - 1  -- c1 is adjacent to c2
    AND c2.seat_id = c3.seat_id - 1  -- c2 is adjacent to c3
    AND c1.free + c2.free + c3.free > 2;  -- All three seats must be free

-- Query to find pairs of adjacent free seats
SELECT 
    * 
FROM cinema c1, cinema c2 
WHERE 
    c1.seat_id != c2.seat_id  -- Ensure the two seats are different
    AND c1.free = 1  -- Seat 1 is free
    AND c2.free = 1  -- Seat 2 is free
    AND (
        (c1.seat_id = c2.seat_id - 1)  -- c1 is adjacent to c2
        OR (c2.seat_id = c1.seat_id - 1)  -- c2 is adjacent to c1
    )
ORDER BY c1.seat_id;  -- Order results by the first seat ID

-- Query to find seats that are free and have adjacent seats also free
SELECT 
    c1.seat_id 
FROM cinema c1 
WHERE 
    free = 1  -- Seat is free
    AND (
        seat_id + 1 IN (SELECT seat_id FROM cinema WHERE free = 1)  -- Adjacent seat on the right is free
        OR seat_id - 1 IN (SELECT seat_id FROM cinema WHERE free = 1)  -- Adjacent seat on the left is free
    )
ORDER BY seat_id;  -- Order results by seat ID
