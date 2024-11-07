-- Enable PostGIS extension if not already enabled
CREATE EXTENSION IF NOT EXISTS postgis;

-- https://en.wikipedia.org/wiki/Spatial_reference_system
CREATE TABLE nodes
(
    node_id   SERIAL PRIMARY KEY,
    parent_id INT REFERENCES nodes (node_id),
    level     INT,
    bounds    GEOMETRY(POLYGON, 4326), --to store spatial bounding box
    has_lod   BOOLEAN,
    CONSTRAINT ck_level CHECK (level >= 0 AND level <= 3)
);

CREATE TABLE node_lods
(
    lod_id        SERIAL PRIMARY KEY,
    node_id       INT REFERENCES nodes (node_id),
    lod_level     INT,
    geometry_size INT CHECK (geometry_size <= 512 * 1024), -- Scenario 1 constraint
    blob_id       OID
);
