-- Tables creation

DROP TABLE IF EXISTS docs02 CASCADE;
CREATE TABLE docs02 (
  id SERIAL,
  doc TEXT,
  PRIMARY KEY(id)
);


DROP TABLE IF EXISTS invert02 CASCADE;
CREATE TABLE invert02 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs02(id) ON DELETE CASCADE
);


-- Populate docs with some text data
INSERT INTO docs02 (doc) VALUES
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


-- Create stop_words table to store all stop words that will be excluded in the inverted index table
DROP TABLE IF EXISTS stop_words CASCADE;
CREATE TABLE stop_words (
  word TEXT unique
);

INSERT INTO stop_words (word) VALUES 
('i'), ('a'), ('about'), ('an'), ('are'), ('as'), ('at'), ('be'), 
('by'), ('com'), ('for'), ('from'), ('how'), ('in'), ('is'), ('it'), ('of'), 
('on'), ('or'), ('that'), ('the'), ('this'), ('to'), ('was'), ('what'), 
('when'), ('where'), ('who'), ('will'), ('with')
;


-- Insert all words in lowercase into the inverted index table
INSERT INTO invert02
  SELECT DISTINCT
    s.keyword AS keyword
    ,id AS doc_id
  FROM
    docs02 d
    CROSS JOIN LATERAL
      unnest(string_to_array(lower(d.doc), ' ')) s(keyword) -- This CROSS JOIN  between doc02 and itself is done implicitly PER ROW, so that, each keyword is associated with it's doc_id. Weird one. 
  WHERE keyword NOT IN (SELECT word FROM stop_words)
;
