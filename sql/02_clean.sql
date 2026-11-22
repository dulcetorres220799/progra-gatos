CREATE SCHEMA IF NOT EXISTS clean;

CREATE OR REPLACE TABLE clean.delitos_LA AS
SELECT
    "DATE OCC"::DATE AS fecha_occ,          
    "TIME OCC"::INTEGER AS hora_occ,        
    "AREA"::INTEGER AS num_area,            
    "AREA NAME"::VARCHAR AS nom_area,       
    "Crm Cd Desc"::VARCHAR AS delito,       
    "Vict Sex"::VARCHAR AS sexo_vic,        
    "Vict Age"::INTEGER AS edad_vic         
FROM raw.delitos_LA;