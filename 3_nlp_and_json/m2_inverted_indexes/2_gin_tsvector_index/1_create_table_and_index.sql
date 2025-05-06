-- Create a table to store the text	
DROP TABLE IF EXISTS docs03 CASCADE;
CREATE TABLE docs03 (
  id SERIAL,
  doc TEXT,
  PRIMARY KEY(id))
;

-- Create the GIN index. The function to_tsvector lowercases the entire column and removes stop words, then the index is created
DROP INDEX IF EXISTS fulltext03 CASCADE;
CREATE INDEX fulltext03 ON docs03 USING gin(to_tsvector('english', doc));

-- Insert some sample text with the target word into the table
INSERT INTO docs03 (doc) VALUES
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

-- To use the GIN Index Postgre requires a larger table, so we insert dummy text data
INSERT INTO docs03 (doc) 
  SELECT 'Neon ' || generate_series(10000,20000)
;
