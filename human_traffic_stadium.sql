-- Drop the 'stadium' table if it exists
DROP TABLE stadium;

-- Create the 'stadium' table with columns: id, date1, people
CREATE TABLE stadium (
    id NUMBER,              -- ID of the stadium record
    date1 DATE,             -- Date of the event
    people INT              -- Number of people attending
);

-- Insert sample data into the 'stadium' table
INSERT INTO stadium (id, date1, people) 
VALUES ('1', TO_DATE('2017-01-01', 'YYYY-MM-DD'), '10');  -- 10 people on 2017-01-01

INSERT INTO stadium (id, date1, people) 
VALUES ('2', TO_DATE('2017-01-02', 'YYYY-MM-DD'), '109');  -- 109 people on 2017-01-02

INSERT INTO stadium (id, date1, people) 
VALUES ('3', TO_DATE('2017-01-03', 'YYYY-MM-DD'), '150');  -- 150 people on 2017-01-03

INSERT INTO stadium (id, date1, people) 
VALUES ('4', TO_DATE('2017-01-04', 'YYYY-MM-DD'), '99');   -- 99 people on 2017-01-04

INSERT INTO stadium (id, date1, people) 
VALUES ('5', TO_DATE('2017-01-05', 'YYYY-MM-DD'), '145');  -- 145 people on 2017-01-05

INSERT INTO stadium (id, date1, people) 
VALUES ('6', TO_DATE('2017-01-06', 'YYYY-MM-DD'), '1455'); -- 1455 people on 2017-01-06

INSERT INTO stadium (id, date1, people) 
VALUES ('7', TO_DATE('2017-01-07', 'YYYY-MM-DD'), '199');  -- 199 people on 2017-01-07

INSERT INTO stadium (id, date1, people) 
VALUES ('8', TO_DATE('2017-01-08', 'YYYY-MM-DD'), '188');  -- 188 people on 2017-01-08

-- Select distinct rows where the attendance for 3 consecutive days is >= 100 people
SELECT DISTINCT t1.*
FROM stadium t1, stadium t2, stadium t3
WHERE t1.people >= 100  -- t1's attendance must be >= 100
  AND t2.people >= 100  -- t2's attendance must be >= 100
  AND t3.people >= 100  -- t3's attendance must be >= 100
  AND (
    -- First possible combination: t1, t2, t3 in consecutive order
    (t1.id - t2.id = 1 AND t1.id - t3.id = 2 AND t2.id - t3.id = 1)
    OR
    -- Second possible combination: t2, t1, t3 in consecutive order
    (t2.id - t1.id = 1 AND t2.id - t3.id = 2 AND t1.id - t3.id = 1)
    OR
    -- Third possible combination: t3, t2, t1 in consecutive order
    (t3.id - t2.id = 1 AND t2.id - t1.id = 1 AND t3.id - t1.id = 2)
  )
ORDER BY t1.id, t1.date1;  -- Order the results by ID and date
