-- Select all distinct albums from the raw data and create a row for each one in the album table. The album  ID is assigned automatically 
INSERT INTO album (title) SELECT DISTINCT album FROM track_raw ;

-- Fill the album_id field in the raw table
UPDATE track_raw SET album_id = (SELECT album.id FROM album WHERE album.title = track_raw.album);

-- From the raw table with all fields filled, pull the data with the required field to populate the normalised table.
INSERT INTO track
    (title, len, rating, count, album_id)
SELECT
    title, len, rating, count, album_id
FROM
    track_raw;
