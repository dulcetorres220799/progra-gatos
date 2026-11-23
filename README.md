
**Tarea 4: De datos crudos a un reporte reproducible con Quarto**


**Equipo:**

Equipo "gatos", conformado por Guillermo Castillo y Dulce Torres. 

**Nombre y fuente de la base de datos seleccionada:**

Decidimos utilizar la misma base que exploramos en la tarea 3: Datos sobre criminalidad en Los Ángeles de 2020 a 2024.

Los Angeles Open Data: https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-2024/2nrs-mtv8/about_data

**Enlace de descarga:**

https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD

**Condiciones de uso disponibles:**

Si bien el registro pertenece al departamento de la policía de Los Angeles, el archivo se encuentra publicado por el gobierno de la ciudad mediante su portal de datos abiertos. Dentro de la página no hay una justificación de por qué se encuentra pública; sin embargo, dentro del ecosistema de datos abiertos, conocer la ocurrencia y ubicación de los delitos constituye un ejercicio de transparencia valioso para la ciudadanía, la academia y el sector empresarial.

**Cobertura:**

La base registra los delitos denunciados o conocidos por el departamento de policía de Los Angeles (LAPD), California durante el periodo 2020 a 2024. Su cobertura geográfica abarca 21 áreas geográficas de la ciudad de Los Ángeles, California.

**Preguntas desarrolladas en el análisis de la base:**

Pregunta 1: ¿Cuáles son los 3 delitos más frecuentes en el acumulado 2020–2023, según el sexo de la víctima?

Pregunta 2: Los 3 delitos más frecuentes por sexo de la víctima, ¿ocurren de manera homogénea entre las 21 áreas geográficas o se concentran en áreas específicas?

**Principales columnas utilizadas (tal cual aparecen en la base original -capa raw-):**

- `DATE OCC`: fecha de ocurrencia del incidente
- `TIME OCC`: hora de ocurrencia del incidente
- `AREA`: número correspondiente a cada una de las 21 áreas o divisiones de patrulla 
- `AREA NAME`: nombre de las 21 áreas geográficas o divisiones de patrulla
- `Crm Cd`: delito cometido
- `Vict Sex`: sexo de la víctima
- `Vict Age`: edad de la víctima

**Unidad de observación:**

Cada fila representa un incidente delictivo (crime incident).

**Descripción de las capas:**

- `raw`: Corresponde a datos de origen, sin transformaciones.
- `clean`: Corresponde a datos estandarizados y validados, con base en las instrucciones descritas en el archivo sql/02_clean.sql
- `model`: Corresponde a entidades, eventos u otras tablas desarrolladas para el análisis e interpretación de datos, con base en las instrucciones descritas en el archivo sql/03_model.sql

**Decisiones importantes de limpieza:**

En la capa `clean` se crea la tabla `delitos_LA` solo con los delitos de 2020 a 2023 y con las columnas necesarias para el análisis, renombradas con minúsculas y sin espacios, y con el tipo de dato correcto. El texto de fecha y hora se convierte en una fecha completa, y a partir de ella se obtienen la hora, el día de la semana y el año. 

Los valores no válidos de sexo de la víctima (todo lo que no es F, M o X) y de edad (lo que queda fuera de 1 a 99) se dejan como vacíos.

Las columnas renombradas se muestran a continuación:

- `fecha_occ`: TIMESTAMP
- `hora_occ`: INTEGER
- `diasem`: INTEGER
- `anio`: INTEGER
- `num_area`: INTEGER
- `nom_area`: VARCHAR
- `delito`: VARCHAR
- `sexo_vic`: VARCHAR
- `edad_vic`: INTEGER

**Advertencias sobre la calidad de los datos:**

Se reconocen dos observaciones:

1. Al revisar el número de registros por año, se evidencia una caída significativa en el número de registros para el año 2024, especialmente a partir de marzo. Al revisar la documentación del archivo, detectamos que el LAPD transitó a un diferente esquema de registro de incidentes delictivos (UCR a NIBRS). No obstante, no hay aclaraciones sobre por qué unos incidentes sí fueron registrados y otros no. Por esta razón, decidimos acotar el análisis para los registros que tuvieran como año de ocurrencia entre 2020 y 2023.

2. Al trabajar únicamente con delitos determinados por el sexo de la víctima (F o M) es posible que se descarten delitos cuyo sexo de la víctima fue mal capturado o desconocido, así como delitos en donde no necesariamente se reporta el sexo de una víctima, como en el robo de vehículos.

**Cómo recuperar el CSV original usando CLI:**

Paso 1: `mkdir -p data/raw data/db` para crear los directorios

Paso 2: `curl -L "https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD" -o data/raw/delitos_LA.csv` para descargar la base y guardarla en la capa `raw`

**Cómo instalar dependencias (uv sync):**

Paso 1: Ejecutar `curl -LsSf https://astral.sh/uv/install.sh | sh` para instalar uv

Paso 2: Cuando termine la instalación, cerrar y volver a abrir la terminal para verificar con `uv --version`

Paso 3: Ejecutar `cd nombre_repositorio` para ubicarnos en el repositorio del proyecto

Paso 4: Ejecutar `uv init --bare` para crear el propio ambiente virtual del proyecto 

Paso 5: Ejecutar `uv python pin 3.12` para fijar la versión de Python que se usará

Paso 6: Ejecutar los siguientes comandos para agregar las paqueterías necesarias y el kernel: 

- `uv add duckdb`
- `uv add pandas`
- `uv add matplotlib`
- `uv add ipykernel`
- `uv add seaborn`

Paso 7: Ejecutar `uv sync` para sincronizar dependencias. 

**Cómo construir DuckDB con los SQL, desde una base vacía:**

Paso 1: Ejecutar `curl https://install.duckdb.org | bash` para instalar el modelo embebido duckdb

Paso 2: Ejecutar los sigueintes comandos para crear las tres capas:

`duckdb data/db/delitos_LA.duckdb -f sql/01_raw.sq`
`duckdb data/db/delitos_LA.duckdb -f sql/02_clean.sql`
`duckdb data/db/delitos_LA.duckdb -f sql/03_model.sql`

**Cómo ejecutar ambos notebooks:**

Paso 1: Ejecutar `code .` desde la raíz del repositorio para abrir el proyecto en VS

Paso 2: Abrir `notebooks/nb01_estructura_perfilado.ipynb` y seleccionar el kernel `.venv` en "Select Kernel" para usar el ambiente del proyecto

Paso 3: Seleccionar "Restart" y después "Run All" para ejecutar el notebook de principio a fin

Paso 4: Abrir `notebooks/nb02_preguntas_visualizaciones.ipynb` y repetir los pasos 2 y 3 para ejecutar el análisis y generar las figuras en `docs/imgs/`

**Cómo regenerar las figuras:** 

Después del EDA en `notebooks/nb02_preguntas_visualizaciones.ipynb`, las visualizaciones generadas se guardan en `docs/imgs/` con el comando:

`fig.tight_layout()`
`fig.savefig("../docs/imgs/figura_01.png", dpi=160, bbox_inches="tight")`

Cada figura se guarda con un nombre distinto (`figura_01.png`, `figura_02.png`, etc.). Para regenerarlas, basta con volver a ejecutar completo el notebook

**Cómo renderizar docs/reporte.qmd:**

Paso 1: Ejecutar `cd nombre_repositorio` para ubicarnos en el repositorio del proyecto

Paso 2: Ejecutar `quarto render docs/reporte.qmd` para generar el reporte

**Audiencia, preguntas e interpretaciones principales del reporte; rutas de las figuras publicadas:**

**Audiencia:** Público general y estudiantes interesados en la incidencia delictiva en Los Ángeles.

**Pregunta 1:** ¿Cuáles son los 3 delitos más frecuentes en el acumulado 2020–2023, según el sexo de la víctima?

**Hallazgo principal:** En las mujeres, el delito más frecuente es la agresión simple por parte de la pareja íntima; en los hombres, la agresión física simple. Esto sugiere que el principal delito contra las mujeres ocurre en un contexto de violencia de género, aunque los datos por sí solos no permiten comprobar sus causas.

**Pregunta 2:** Los 3 delitos más frecuentes por sexo de la víctima, ¿ocurren de manera homogénea entre las 21 áreas geográficas o se concentran en áreas específicas?

**Hallazgo principal:** Los delitos no se distribuyen de manera homogénea; para ambos sexos se concentran principalmente en 77th Street y Southeast, y en los hombres también destaca Central. Sin embargo, los datos son cifras absolutas y no tasas por habitantes, por lo que no se puede afirmar que un área sea más violenta que otra.

**Rutas de las figuras publicadas:**

- Pregunta 1: `docs/imgs/figura_01.png`
- Pregunta 2: `docs/imgs/figura_02.png` 

**Breve reflexión: ¿qué fue lo más difícil?, ¿qué hallazgo es más sólido y cuál más frágil?, ¿qué cambiarían con más tiempo?**

Lo más difícil fue construir las capas `clean` y `model` en SQL, ya que si no estaban bien escritas no se podían ejecutar en la terminal ni continuar con los pasos siguientes. La capa `clean` implicó explorar la base para identificar qué era necesario limpiar y bajo qué criterios, además de tener claras las preguntas para saber qué variables conservar. Uno de los principales retos fue transformar la fecha y la hora, que venían como texto y en formatos distintos, para unirlas en una sola variable de fecha y obtener a partir de ella la hora, el día de la semana y el año. También fue necesario definir criterios para dejar como vacíos los valores no válidos de sexo de la víctima (distintos de F, M o X) y de edad (fuera del rango de 1 a 99), así como filtrar únicamente los delitos ocurridos entre 2020 y 2023. De igual forma, la capa `model` requirió tener bien definidas las preguntas para saber qué información se quería mostrar en las gráficas.

El hallazgo más sólido es el de los delitos más frecuentes por sexo de la víctima, ya que se obtiene directamente del conteo de casos registrados, aunque con la limitación de considerar solo los registros con sexo bien clasificado como masculino o femenino. Aun así, muestra una diferencia clara entre hombres y mujeres en materia de incidencia delictiva. El más frágil es el de la concentración de delitos por área, porque se basa en cifras absolutas y no en tasas por habitantes, por lo que no permite comparar el riesgo entre áreas.

Con más tiempo se incorporarían datos de población por área para calcular tasas por cada 100 mil habitantes y comparar las áreas de forma más justa. También se podría analizar la evolución de los delitos año con año para identificar tendencias.
