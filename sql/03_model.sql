CREATE SCHEMA IF NOT EXISTS model; 
 -- Pregunta 1: ¿qué delitos han sido los más frecuentes, según el sexo de la víctima?
 -- 1 fila = combinación de sexo de la víctima por tipo de delito

CREATE OR REPLACE TABLE model.del_sexo AS
SELECT
     anio,
     sexo_vic,
     delito,
    COUNT(*) AS n_delitos
FROM clean.delitos_LA
WHERE sexo_vic IN ('F','M')
    AND anio BETWEEN 2020 AND 2023
GROUP BY anio,sexo_vic, delito;


  -- Pregunta 2: ¿en qué áreas se concentran los delitos?
  -- 1 fila = un área con su porcentaje de delitos correspondiente y su porcentaje acumulado

CREATE OR REPLACE TABLE model.areas_concentracion AS
SELECT
     num_area,
     nom_area,
     COUNT(*) AS n_delitos,
     100 * COUNT(*) / SUM(COUNT(*)) OVER () AS pct,
     100* SUM(COUNT(*)) OVER (ORDER BY COUNT(*) DESC, num_area)
       / SUM(COUNT(*)) OVER() AS pct_acum
FROM clean.delitos_LA
WHERE anio BETWEEN 2020 AND 2023
GROUP BY num_area, nom_area;    

