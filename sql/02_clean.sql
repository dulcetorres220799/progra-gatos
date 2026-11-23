CREATE SCHEMA IF NOT EXISTS clean;

CREATE OR REPLACE TABLE clean.delitos_LA AS
SELECT
    (strptime("DATE OCC", '%m/%d/%Y %I:%M:%S %p')::DATE
    + strptime(lpad("TIME OCC", 4, '0'), '%H%M')::TIME) AS fecha_occ,
    "TIME OCC":: INTEGER // 100 AS hora_occ,
    EXTRACT(ISODOW FROM strptime("DATE OCC", '%m/%d/%Y %I:%M:%S %p'))::INTEGER AS diasem,
    EXTRACT(YEAR FROM strptime("DATE OCC", '%m/%d/%Y %I:%M:%S %p'))::INTEGER AS anio,
    "AREA"::INTEGER AS num_area,
    "AREA NAME"::VARCHAR AS nom_area,
    "Crm Cd Desc"::VARCHAR AS delito,
    CASE WHEN "Vict Sex" IN ('F', 'M', 'X') THEN "Vict Sex" END AS sexo_vic,
    CASE WHEN "Vict Age"::INTEGER BETWEEN 1 AND 99 THEN "Vict Age"::INTEGER END AS edad_vic

FROM raw.delitos_LA
WHERE EXTRACT(YEAR FROM strptime("DATE OCC", '%m/%d/%Y %I:%M:%S %p')) BETWEEN 2020 AND 2024;
