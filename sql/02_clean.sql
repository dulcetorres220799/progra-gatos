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
    "Vict Sex"::VARCHAR AS sexo_vic,
    "Vict Age"::INTEGER AS edad_vic

FROM raw.delitos_LA;
