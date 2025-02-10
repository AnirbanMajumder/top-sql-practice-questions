-- Drop the 'survey' table if it already exists
DROP TABLE survey;

-- Create the 'survey' table with relevant columns
CREATE TABLE survey (
    unid NUMBER(10),          -- Unique User ID
    action VARCHAR2(25),      -- Action performed ('show', 'answer', 'skip')
    question NUMBER(10),      -- Question ID
    answer NUMBER(10),        -- Answer ID (nullable)
    qnum NUMBER(10),          -- Question Number
    ts NUMBER(10)             -- Timestamp of the action
);

-- Insert sample data into the 'survey' table
INSERT INTO survey (unid, action, question, answer, qnum, ts)
VALUES ('5', 'show', '285', NULL, '1', '123');  -- User 5 shows question 285, qnum 1 at timestamp 123

INSERT INTO survey (unid, action, question, answer, qnum, ts)
VALUES ('5', 'answer', '285', '124124', '1', '124');  -- User 5 answers question 285, qnum 1 with answer 124124 at timestamp 124

INSERT INTO survey (unid, action, question, answer, qnum, ts)
VALUES ('5', 'show', '369', NULL, '2', '125');  -- User 5 shows question 369, qnum 2 at timestamp 125

INSERT INTO survey (unid, action, question, answer, qnum, ts)
VALUES ('5', 'skip', '369', NULL, '2', '126');  -- User 5 skips question 369, qnum 2 at timestamp 126

-- Select the question with the highest ratio of 'answer' to 'show' actions
SELECT question AS survey_log
FROM
(
    -- Subquery to calculate the number of 'answer' and 'show' actions for each question
    SELECT
        question,
        SUM(CASE WHEN action = 'answer' THEN 1 ELSE 0 END) AS num_answer,  -- Count 'answer' actions
        SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) AS num_show        -- Count 'show' actions
    FROM 
        survey
    GROUP BY question
    ORDER BY (num_answer / num_show) DESC  -- Order by the ratio of answers to shows, descending
)
WHERE rownum = 1;  -- Select the question with the highest answer-to-show ratio
