DROP TABLE IF EXISTS album CASCADE;
CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS artist CASCADE;
CREATE TABLE artist (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track CASCADE;
CREATE TABLE track (
  id SERIAL,
  title TEXT,
  artist TEXT,
  album TEXT,
  album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
  count INTEGER,
  rating INTEGER,
  len INTEGER,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS tracktoartist CASCADE;
CREATE TABLE tracktoartist (
  id SERIAL,
  track VARCHAR(128),
  track_id INTEGER REFERENCES track(id),
  artist VARCHAR(128),
  artist_id INTEGER REFERENCES artist(id),
  PRIMARY KEY(id)
);

