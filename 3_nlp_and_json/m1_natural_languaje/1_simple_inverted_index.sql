-- Tables creation

DROP TABLE IF EXISTS docs01 CASCADE;
CREATE TABLE docs01 (
  id SERIAL,
  doc TEXT,
  PRIMARY KEY(id)
);


DROP TABLE IF EXISTS invert01 CASCADE;
CREATE TABLE invert01 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs01(id) ON DELETE CASCADE
);


-- Populate docs with some text data
INSERT INTO docs01 (doc) VALUES
('humantodog language The nice thing about telling Python to speak is'),
('that we can even tell it what to say by giving it a message in quotes'),
('And we have even written our first syntactically correct Python'),
('sentence Our sentence starts with the function print'),
('followed by a string of text of our choosing enclosed in single quotes'),
('The strings in the print statements are enclosed in quotes Single'),
('quotes and double quotes do the same thing most people use single'),
('quotes except in cases like this where a single quote which is also an'),
('apostrophe appears in the string'),
('Now that we have a word and a simple sentence that we know in Python we')
;


-- Insert all words in lowercase into the inverted index table
INSERT INTO invert01
  SELECT DISTINCT
    unnest(string_to_array(lower(doc), ' ')) AS keyword -- a) Turn into lowercase b) Transform into array c) unnest
    ,id AS doc_id
  FROM docs01
;
