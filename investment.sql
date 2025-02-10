-- Create the 'insurance' table with columns for PID, TIV values for 2015 and 2016, and latitude and longitude
CREATE TABLE insurance (
    PID NUMBER(11),              -- Property ID
    TIV_2015 NUMBER(15,2),       -- Total Insured Value for 2015
    TIV_2016 NUMBER(15,2),       -- Total Insured Value for 2016
    LAT NUMBER(5,2),             -- Latitude of the property
    LON NUMBER(5,2)              -- Longitude of the property
);

-- Insert sample data into the 'insurance' table
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) 
VALUES ('1', '10', '5', '10', '10');  -- Property 1 with TIV values for 2015 and 2016, and coordinates

INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) 
VALUES ('2', '20', '20', '20', '20');  -- Property 2 with TIV values for 2015 and 2016, and coordinates

INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) 
VALUES ('3', '10', '30', '20', '20');  -- Property 3 with TIV values for 2015 and 2016, and coordinates

INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) 
VALUES ('4', '10', '40', '40', '40');  -- Property 4 with TIV values for 2015 and 2016, and coordinates

-- Select the sum of TIV for 2016, filtering based on specific conditions:
SELECT SUM(tiv_2016) AS TIV_2016  -- Calculate the sum of TIV for 2016
FROM insurance t1
WHERE tiv_2015 IN (  -- Filter properties where TIV in 2015 matches those of another property (excluding itself)
    SELECT tiv_2015
    FROM insurance t2
    WHERE t1.pid <> t2.pid  -- Ensure the property being compared is not the same as the current property
)
AND (lat, lon) NOT IN (  -- Exclude properties with the same latitude and longitude
    SELECT lat, lon
    FROM insurance t3
    WHERE t1.pid <> t3.pid  -- Ensure the property being compared is not the same as the current property
);
