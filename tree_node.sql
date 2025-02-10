-- Create the 'tree' table with columns for id and p_id (parent id)
CREATE TABLE tree (
    id NUMBER,                  -- Unique identifier for the tree node
    p_id NUMBER                 -- Parent id, which references another node's id (NULL for the root)
);

-- Insert sample data into the 'tree' table, defining parent-child relationships
INSERT INTO tree(id, p_id) 
VALUES('1', NULL);  -- Node 1 is the root node (no parent)

INSERT INTO tree(id, p_id) 
VALUES('2', '1');  -- Node 2 is a child of Node 1

INSERT INTO tree(id, p_id) 
VALUES('3', '1');  -- Node 3 is a child of Node 1

INSERT INTO tree(id, p_id) 
VALUES('4', '2');  -- Node 4 is a child of Node 2

INSERT INTO tree(id, p_id) 
VALUES('5', '2');  -- Node 5 is a child of Node 2

-- Query to classify each node as 'Root', 'Inner', or 'Leaf' based on its parent-child relationship
SELECT 
    id, 
    CASE 
        WHEN p_id IS NULL THEN 'Root'                      -- If p_id is NULL, it's the root node
        WHEN p_id IS NOT NULL AND id IN (SELECT DISTINCT p_id FROM tree) THEN 'Inner' -- If the node has a parent and is also a parent itself, it's an inner node
        ELSE 'Leaf'                                        -- Otherwise, it's a leaf node (a node with no children)
    END AS Type 
FROM tree
ORDER BY id;  -- Order the result by id for better readability
