--  Searches the docs03 table for documents that contain the word "syntactically" or its variations.
SELECT id, doc 
FROM docs03 
WHERE to_tsquery('english', 'syntactically') @@ to_tsvector('english', doc);
-- The @@ operator is used to match the text search query against the text search vector. 
-- In this case, it checks if the query for "syntactically" matches any occurrence of the word or its variations within the doc column
