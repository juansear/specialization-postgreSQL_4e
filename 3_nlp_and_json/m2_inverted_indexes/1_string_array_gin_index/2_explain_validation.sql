-- Use this command to validate pgsql is using the index internally
-- The output should be something like: "Bitmap heap scan ..."
-- The output shouldn't be: "Seq scan..."

EXPLAIN 
    SELECT id, doc 
    FROM docs03 
    WHERE '{syntactically}' <@ string_to_array(lower(doc), ' ')
;
