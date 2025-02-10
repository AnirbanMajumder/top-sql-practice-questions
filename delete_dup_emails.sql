-- Delete duplicate rows from the 'Person' table based on the 'Email' column,
-- keeping the row with the smallest 'Id' for each 'Email'.
DELETE p1 
FROM Person p1,
     Person p2
WHERE
    -- Check if both rows have the same 'Email' value
    p1.Email = p2.Email
    -- Ensure that the first row has a larger 'Id' value than the second row,
    -- effectively keeping the row with the smaller 'Id' (the duplicate row)
    AND p1.Id > p2.Id;
