SELECT
  track.title,
  album.title,
  artist.name
FROM
  track
  JOIN album ON track.album_id = album.id
  JOIN tracktoartist ON track.id = tracktoartist.track_id
  JOIN artist ON tracktoartist.artist_id = artist.id
LIMIT 3;
