INSERT INTO album (title) SELECT DISTINCT album FROM track;
INSERT INTO tracktoartist (track, artist) SELECT DISTINCT title, artist FROM track;
INSERT INTO artist (name) SELECT DISTINCT artist FROM track;

UPDATE track SET album_id = (SELECT id FROM album WHERE album.title = track.album);
UPDATE tracktoartist SET track_id = (SELECT id FROM track WHERE tracktoartist.track = track.title);
UPDATE tracktoartist SET artist_id = (SELECT id FROM artist WHERE tracktoartist.artist = artist.name);

ALTER TABLE track DROP COLUMN artist;
ALTER TABLE track DROP COLUMN album;
ALTER TABLE tracktoartist DROP COLUMN track;
ALTER TABLE tracktoartist DROP COLUMN artist;
