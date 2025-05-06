SELECT
  id,
  doc
FROM docs03
WHERE '{syntactically}' <@ string_to_array(lower(doc), ' ')
-- The operator <@ is used to check array containment 
