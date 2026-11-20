CREATE SCHEMA IF NOT EXISTS clean;

CREATE OR REPLACE TABLE clean.delitos_LA AS
SELECT

    (date_occ::DATE +strptime(time_occ, '%H%M')::TIME) AS fecha_occ,
    (time_occ::INTEGER // 100) AS hora,
    EXTRACT(ISODOW FROM date_occ::DATE)::INTEGER AS diasem,
    EXTRACT(YEAR FROM date_occ::DATE)::INTEGER AS anio,
    area::INTEGER AS num_area,
    area_name::VARCHAR AS nom_area,
    crm_cd_desc::VARCHAR AS delito,
    CASE WHEN vict_sex IN ('F', 'M', 'X') THEN vict_sex END AS sexo_vic, 
    CASE WHEN vict_age::INTEGER BETWEEN 1 AND 99 THEN vict_age::INTEGER END AS edad_vic

FROM raw.delitos_LA;
