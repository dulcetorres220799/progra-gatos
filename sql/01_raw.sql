CREATE SCHEMA IF NOT EXISTS raw;

CREATE OR REPLACE TABLE raw.delitos_LA AS
SELECT *
FROM read_csv('data/raw/delitos_LA.csv', all_varchar = true);