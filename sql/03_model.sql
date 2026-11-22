CREATE SCHEMA IF NOT EXISTS model;

-- Pregunta 1: ¿cuáles son los 3 delitos más frecuentes en el acumulado 2020–2023, según el sexo de la víctima?

CREATE OR REPLACE TABLE model.del_sexo AS
SELECT
    sexo_vic,                                   
    delito,                                     
    COUNT(*) AS n_delitos                       
FROM clean.delitos_LA
WHERE sexo_vic IN ('F', 'M')                    
  AND fecha_occ >= '2020-01-01'::DATE           
  AND fecha_occ <  '2024-01-01'::DATE           
GROUP BY sexo_vic, delito;

-- Pregunta 2: los 3 delitos más frecuentes por sexo de la víctima, ¿ocurren de manera homogénea entre las 21 áreas geográficas o se concentran en áreas específicas?

CREATE OR REPLACE TABLE model.del_area AS
SELECT
    sexo_vic,                                   
    delito,                                     
    num_area,                                   
    nom_area,                                   
    COUNT(*) AS n_delitos                       
FROM clean.delitos_LA
WHERE sexo_vic IN ('F', 'M')                    
  AND fecha_occ >= '2020-01-01'::DATE           
  AND fecha_occ <  '2024-01-01'::DATE
GROUP BY sexo_vic, delito, num_area, nom_area;
