DROP TABLE unesco_raw;
CREATE TABLE unesco_raw(
  name TEXT, description TEXT, 
  justification TEXT, year INTEGER,
  longitude FLOAT, latitude FLOAT, 
  area_hectares FLOAT,
  category TEXT, category_id INTEGER, 
  state TEXT, state_id INTEGER,
  region TEXT, region_id INTEGER, 
  iso TEXT, iso_id INTEGER
);

DROP TABLE category;
CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE region;
CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE state;
CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  region_id INTEGER REFERENCES region(id) ON DELETE CASCADE,
  PRIMARY KEY(id)
);

DROP TABLE iso;
CREATE TABLE iso (
  id SERIAL,
  name CHAR(2) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE unesco;
CREATE TABLE  unesco (
  id SERIAL,
  name TEXT  UNIQUE,
  description TEXT,
  justification TEXT,
  year INTEGER,
  longitude FLOAT,
  latitude FLOAT,
  area_hectares FLOAT,
  category_id INTEGER REFERENCES category(id) ON DELETE CASCADE,
  state_id INTEGER REFERENCES state(id) ON DELETE CASCADE,
  region_id INTEGER REFERENCES region(id) ON DELETE CASCADE,
  iso_id INTEGER REFERENCES iso(id) ON DELETE CASCADE,
  PRIMARY KEY(id)
);
