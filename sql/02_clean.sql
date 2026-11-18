CREATE SCHEMA IF NOT EXISTS clean;

CREATE OR REPLACE TABLE clean.delitos_LA AS
SELECT
    -- columnas renombradas y transformadas

date_occ::TIMESTAMP AS fecha_occ,
      EXTRACT(ISODOW FROM date_occ)::int AS dia_semana,
      EXTRACT(HOUR FROM date_occ)::int AS hora,
      EXTRACT(YEAR FROM date_occ)::int AS anio,
area_name::VARCHAR AS nombre_area,
crm_cd::VARCHAR AS delito,
vict_sex::VARCHAR AS sexo_vic, 
vict_age::VARCHAR AS edad_vic

FROM raw.delitos_LA;