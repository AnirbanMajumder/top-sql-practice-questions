-- Create the 'Weather' table to store weather data such as temperature records
CREATE TABLE Weather (
    Id INT,                 -- Unique identifier for each weather record
    RecordDate DATE,        -- Date when the weather record was taken
    Temperature INT         -- Recorded temperature on that date (in degrees)
);

-- Insert sample weather data into the 'Weather' table
INSERT INTO Weather (Id, RecordDate, Temperature) 
VALUES ('1', TO_DATE('2015-01-01', 'YYYY-MM-DD'), '10');  -- Record for Jan 1, 2015 with temperature 10°C

INSERT INTO Weather (Id, RecordDate, Temperature) 
VALUES ('2', TO_DATE('2015-01-02', 'YYYY-MM-DD'), '25');  -- Record for Jan 2, 2015 with temperature 25°C

INSERT INTO Weather (Id, RecordDate, Temperature) 
VALUES ('3', TO_DATE('2015-01-03', 'YYYY-MM-DD'), '20');  -- Record for Jan 3, 2015 with temperature 20°C

INSERT INTO Weather (Id, RecordDate, Temperature) 
VALUES ('4', TO_DATE('2015-01-04', 'YYYY-MM-DD'), '30');  -- Record for Jan 4, 2015 with temperature 30°C

-- Query to find records where the temperature on the current date was higher than the previous day
SELECT curr.id  -- Select the current record's ID
FROM Weather curr
JOIN Weather prev ON curr.RecordDate - 1 = prev.RecordDate  -- Join current and previous records based on consecutive dates
WHERE curr.Temperature - prev.Temperature > 0;  -- Filter where current day's temperature is greater than the previous day
