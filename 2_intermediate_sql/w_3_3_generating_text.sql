CREATE TABLE bigtext (
  content TEXT
);

INSERT INTO bigtext

SELECT
  'This is record number ' || generate_series(100000, 200000, 1) || ' of quite a few text records'  
