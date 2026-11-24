CREATE SCHEMA IF NOT EXISTS model;

-- ---------------------------------------------------------------------
-- Periodo de análisis: 2020–2023.
-- Se excluye 2024 porque el 7 de marzo de 2024, LAPD cambió su sistema
-- de registro (UCR a NIBRS) y los registros de ese año están
-- incompletos (ver nb01). La capa clean conserva 2020–2024.
-- ---------------------------------------------------------------------

-- Pregunta: ¿cuáles son los tres delitos más frecuentes en el acumulado
-- 2020–2023, según el sexo de la víctima?

CREATE OR REPLACE TABLE model.del_sexo AS
SELECT
    sexo_vic,                                   
    delito,
    anio,                                 
    COUNT(*) AS n_delitos                       
FROM clean.delitos_LA
WHERE sexo_vic IN ('F', 'M')                    
  AND anio BETWEEN 2020 AND 2023           
GROUP BY sexo_vic, delito, anio;

-- --------------------------------------------------------------------
-- Pregunta: ¿en qué días de la semana y horas ocurre el principal
-- delito de cada sexo?
-- Una fila = una combinación sexo × delito × día de la semana × hora,
-- con su número de registros acumulados en 2020–2023.
-- La variable diasem retoma el esquema ISO, de forma que:
-- 1 = lunes … 7 = domingo.
-- La variable hora_occ tiene formato de 24 horas: 0 a 23
-- -------------------------------------------------------------------
CREATE OR REPLACE TABLE model.del_dia_hora AS
SELECT
    sexo_vic,
    delito,
    diasem,
    hora_occ,
    COUNT(*) AS n_delitos
FROM clean.delitos_LA
WHERE sexo_vic IN ('F', 'M')
  AND anio BETWEEN 2020 AND 2023
GROUP BY sexo_vic, delito, diasem, hora_occ;

-- -------------------------------------------------------------------
-- Pregunta: los 3 delitos más frecuentes por sexo de la víctima,
-- ¿ocurren de manera homogénea entre las 21 áreas geográficas o
-- se concentran en áreas específicas?
-- ------------------------------------------------------------------

CREATE OR REPLACE TABLE model.del_area AS
SELECT
    sexo_vic,                                   
    delito,                                     
    num_area,                                   
    nom_area,                                   
    COUNT(*) AS n_delitos                       
FROM clean.delitos_LA
WHERE sexo_vic IN ('F', 'M')                    
  AND anio BETWEEN 2020 AND 2023
GROUP BY sexo_vic, delito, num_area, nom_area;
