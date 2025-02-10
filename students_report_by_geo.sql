-- Define the dataset with a row number assigned to each student partitioned by 'continent'
WITH dataset AS (
    SELECT 
        row_number() OVER (PARTITION BY continent ORDER BY continent) AS rid,  -- Assign a row number to each student in each continent group
        continent,                                                               -- Continent of the student
        name                                                                     -- Name of the student
    FROM student
)
-- Select and decode the results for each continent
SELECT
    -- For America: Display the student's name only if the continent is 'America', otherwise show null
    DECODE(am.continent, 'America', am.name, NULL) AS "America",  

    -- For Asia: Display the student's name only if the continent is 'Asia', otherwise show null
    DECODE(asia.continent, 'Asia', asia.name, NULL) AS "Asia",  

    -- For Europe: Display the student's name only if the continent is 'Europe', otherwise show null
    DECODE(eu.continent, 'Europe', eu.name, NULL) AS "Europe"
FROM
    -- Select only the rows for Europe from the dataset
    (SELECT * FROM dataset WHERE continent = 'Europe') eu

FULL JOIN
    -- Select only the rows for America from the dataset
    (SELECT * FROM dataset WHERE continent = 'America') am
ON 
    eu.rid = am.rid  -- Full join based on the row number (rid) to align students with the same row number

FULL JOIN
    -- Select only the rows for Asia from the dataset
    (SELECT * FROM dataset WHERE continent = 'Asia') asia
ON 
    eu.rid = asia.rid  -- Full join based on the row number (rid) to align students with the same row number


