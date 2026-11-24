
**Tarea 4: De datos crudos a un reporte reproducible con Quarto**


**Equipo:**

Equipo "gatos", conformado por Guillermo Castillo y Dulce Torres. 

**Nombre y fuente de la base de datos seleccionada:**

Decidimos utilizar la misma base que exploramos en la tarea 3: Datos sobre criminalidad en Los Ángeles de 2020 a 2024.

Los Angeles Open Data: https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-2024/2nrs-mtv8/about_data

**Enlace de descarga:**

https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD

**Condiciones de uso disponibles:**

El conjunto de datos *Crime Data from 2020 to 2024* se publica en el portal de datos abiertos de la ciudad de Los Ángeles, con el LAPD como fuente (*attribution*: Los Angeles Police Department), bajo la licencia **Creative Commons 1.0 Universal (dedicación al dominio público, CC0)**: puede copiarse, modificarse y distribuirse sin necesidad de pedir permiso. Aun así, citamos la fuente como buena práctica. Dentro del ecosistema de datos abiertos, conocer la ocurrencia y ubicación de los delitos constituye un ejercicio de transparencia valioso para la ciudadanía, la academia y el sector empresarial.

**Cobertura:**

La base registra los delitos denunciados o conocidos por el departamento de policía de Los Angeles (LAPD), California durante el periodo 2020 a 2024. Su cobertura geográfica abarca 21 áreas geográficas de la ciudad de Los Ángeles, California.

**Preguntas desarrolladas en el análisis de la base:**

Pregunta 1: ¿Cuáles son los tres delitos más frecuentes en el acumulado 2020–2023, según el sexo de la víctima?

Pregunta 2: ¿Cómo evolucionaron por año (2020–2023) los tres delitos más frecuentes de cada sexo?

Pregunta 3: ¿En qué días de la semana y horas ocurre el principal delito de cada sexo?

Pregunta 4: ¿Las áreas que concentran el 50 % de los delitos con víctima mujer son las mismas que para víctima hombre?

Pregunta 5: ¿Qué áreas concentran el 50 % del principal delito de cada sexo, y cómo se comparan con el total de delitos?

Las cinco preguntas usan el mismo universo: 683,121 registros de 2020–2023 con víctima registrada como mujer (F) u hombre (M), equivalentes al 77.9 % de los registros del periodo.

**Principales columnas utilizadas (tal cual aparecen en la base original -capa raw-):**

- `DATE OCC`: fecha de ocurrencia del incidente
- `TIME OCC`: hora de ocurrencia del incidente
- `AREA`: número correspondiente a cada una de las 21 áreas o divisiones de patrulla 
- `AREA NAME`: nombre de las 21 áreas geográficas o divisiones de patrulla
- `Crm Cd Desc`: descripción del delito principal del incidente
- `Vict Sex`: sexo de la víctima
- `Vict Age`: edad de la víctima

**Unidad de observación:**

Cada fila representa un incidente delictivo (crime incident).

**Descripción de las capas:**

- `raw`: Corresponde a datos de origen, sin transformaciones (1,004,894 filas).
- `clean`: Corresponde a datos estandarizados y validados, con base en las instrucciones descritas en el archivo sql/02_clean.sql (1,004,894 filas; 2020–2024).
- `model`: Corresponde a entidades, eventos u otras tablas desarrolladas para el análisis e interpretación de datos, con base en las instrucciones descritas en el archivo sql/03_model.sql. Contiene tres tablas agregadas (`del_sexo`, `del_dia_hora` y `del_area`) construidas sobre 683,121 registros de 2020–2023 con víctima mujer u hombre.

**Decisiones importantes de limpieza:**

En la capa `clean` se crea la tabla `delitos_LA` con todos los registros del archivo original (2020–2024; 1,004,894 filas) y solo con las columnas necesarias para el análisis, renombradas con minúsculas y sin espacios, y con el tipo de dato correcto. La fecha y la hora de ocurrencia, que vienen como texto en dos campos distintos, se unen en una sola variable de fecha y hora (`fecha_occ`); a partir de los campos originales se obtienen además la hora, el día de la semana y el año.

El recorte del periodo de análisis a 2020–2023 no se aplica en `clean`, sino en la capa `model` (ver `sql/03_model.sql`), por las razones descritas en «Advertencias sobre la calidad de los datos». Así, `clean` conserva la serie completa y el perfilado puede mostrar la caída de registros en 2024 que justifica esa decisión.

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

1. Al revisar el número de registros por año, se evidencia una caída significativa en el número de registros para el año 2024, especialmente a partir de marzo. Al revisar la documentación del archivo, detectamos que el LAPD transitó a un diferente esquema de registro de incidentes delictivos (UCR a NIBRS). No obstante, no hay aclaraciones sobre por qué unos incidentes sí fueron registrados y otros no. Por esta razón, decidimos acotar el análisis para los registros que tuvieran como año de ocurrencia entre 2020 y 2023. Este filtro se aplica en la capa `model`.

2. Al trabajar únicamente con delitos determinados por el sexo de la víctima (F o M) es posible que se descarten delitos cuyo sexo de la víctima fue mal capturado o desconocido, así como delitos en donde no necesariamente se reporta el sexo de una víctima, como en el robo de vehículos.

**Cómo instalar dependencias (uv sync):**

Paso 1: Si no tienes uv, instálalo con `curl -LsSf https://astral.sh/uv/install.sh | sh`. Después cierra y vuelve a abrir la terminal, y verifica con `uv --version`.

Paso 2: Clona el repositorio y ubícate en su raíz:

`git clone https://github.com/dulcetorres220799/progra-gatos.git`

`cd progra-gatos`

Paso 3: Ejecuta `uv sync`. Este comando lee `pyproject.toml` y `uv.lock`, crea el ambiente virtual `.venv` e instala exactamente las mismas versiones de las librerías usadas en el proyecto (DuckDB, pandas, matplotlib, seaborn e ipykernel). No es necesario usar `uv init` ni `uv add`: el proyecto ya está configurado.

**Cómo recuperar el CSV original usando CLI:**

Paso 1: `mkdir -p data/raw data/db` para crear los directorios

Paso 2: `curl -L "https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD" -o data/raw/delitos_LA.csv` para descargar la base y guardarla en `data/raw/`

**Cómo construir DuckDB con los SQL, desde una base vacía:**

Paso 1: Si no tienes la CLI de DuckDB, instálala con `curl https://install.duckdb.org | bash`.

Paso 2: Desde la raíz del repositorio, y con el CSV ya descargado en `data/raw/`, ejecuta los tres scripts en orden:

`rm -f data/db/delitos_LA.duckdb`

`duckdb data/db/delitos_LA.duckdb -f sql/01_raw.sql`

`duckdb data/db/delitos_LA.duckdb -f sql/02_clean.sql`

`duckdb data/db/delitos_LA.duckdb -f sql/03_model.sql`

El primer comando borra la base anterior, si existe, para construirla desde cero. Los scripts deben ejecutarse desde la raíz del repositorio, porque las rutas dentro de ellos son relativas a esa carpeta. Si algún notebook está abierto, reinicia o cierra su kernel antes de reconstruir la base: DuckDB no permite escribir en el archivo mientras otro proceso lo tiene abierto.

**Cómo ejecutar ambos notebooks:**

Paso 1: Ejecutar `code .` desde la raíz del repositorio para abrir el proyecto en VS

Paso 2: Abrir `notebooks/nb01_estructura_perfilado.ipynb` y seleccionar el kernel `.venv` en "Select Kernel" para usar el ambiente del proyecto

Paso 3: Seleccionar "Restart" y después "Run All" para ejecutar el notebook de principio a fin

Paso 4: Abrir `notebooks/nb02_preguntas_visualizaciones.ipynb` y repetir los pasos 2 y 3 para ejecutar el análisis y generar las figuras en `docs/imgs/`

**Cómo regenerar las figuras:** 

Después del EDA en `notebooks/nb02_preguntas_visualizaciones.ipynb`, las visualizaciones generadas se guardan en `docs/imgs/` con el comando:

`fig.tight_layout()`
`fig.savefig("../docs/imgs/figura_01.png", dpi=160, bbox_inches="tight")`

Cada figura se guarda con un nombre distinto (`figura_01.png`, `figura_02.png`, etc.). Para regenerarlas, basta con volver a ejecutar completo el notebook: seleccionar "Restart" y después "Run All", guardar el notebook (`Ctrl + S`) y revisar las figuras antes de hacer `git add`.

**Cómo renderizar docs/reporte.qmd:**

Paso 1: Ejecutar `cd ~` para salir del repositorio y que el instalador de Quarto no se descargue dentro de él

Paso 2: Ejecutar los siguientes comandos para descargar e instalar la versión más reciente de Quarto (pide la contraseña de Ubuntu)

```bash
VERSION=$(curl -s https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/v//')
wget https://github.com/quarto-dev/quarto-cli/releases/download/v${VERSION}/quarto-${VERSION}-linux-amd64.deb
sudo dpkg -i quarto-${VERSION}-linux-amd64.deb
rm quarto-${VERSION}-linux-amd64.deb
```

Paso 3: Ejecutar `quarto --version` para verificar la instalación

Paso 4: Ejecutar `cd nombre_repositorio` para ubicarnos en el repositorio del proyecto

Paso 5: Ejecutar `touch docs/reporte.qmd` para crear el archivo del reporte

Paso 6: Ejecutar `nano docs/reporte.qmd` para escribir el contenido (guardar con `Ctrl+O` y `Enter`, salir con `Ctrl+X`)

Paso 7: Ejecutar `quarto preview docs/reporte.qmd --port 13002` para ver el reporte en `http://localhost:13002/` (detener con `Ctrl+C`)

Paso 8: Ejecutar `quarto render docs/reporte.qmd` para generar el reporte final en `docs/reporte.html`

**Audiencia, preguntas e interpretaciones principales del reporte; rutas de las figuras publicadas:**

**Audiencia:** Público general y estudiantes interesados en la incidencia delictiva en Los Ángeles.

**Pregunta 1:** ¿Cuáles son los tres delitos más frecuentes en el acumulado 2020–2023, según el sexo de la víctima?

**Hallazgo principal:** La lesión física simple es común a ambos sexos, pero el resto de la composición difiere. Entre las mujeres, la lesión simple por parte de la pareja íntima, la lesión física simple y el robo de identidad están prácticamente empatados (entre 32,435 y 33,193 registros); entre los hombres, los tres principales son la lesión física simple, la lesión agravada con arma mortal y el robo al interior de vehículos. La violencia de pareja aparece solo entre los tres principales delitos de las mujeres, aunque los datos por sí solos no permiten establecer sus causas.

**Pregunta 2:** ¿Cómo evolucionaron por año (2020–2023) los tres delitos más frecuentes de cada sexo?

**Hallazgo principal:** La mayoría de los delitos se mantuvo relativamente estable entre 2020 y 2023. La excepción es el robo de identidad con víctima mujer, que pasa de alrededor de 4,500 registros en 2020 a cerca de 14,000 en 2022 y vuelve a bajar en 2023; su lugar entre los tres principales delitos depende en buena medida de ese año.

**Pregunta 3:** ¿En qué días de la semana y horas ocurre el principal delito de cada sexo?

**Hallazgo principal:** La lesión simple por parte de la pareja íntima se concentra en las noches, sobre todo de fin de semana; la lesión física simple contra hombres se concentra en las tardes. La hora de ocurrencia presenta amontonamiento en las 12:00 y las 00:01, que no debe interpretarse como concentración real.

**Pregunta 4:** ¿Las áreas que concentran el 50 % de los delitos con víctima mujer son las mismas que para víctima hombre?

**Hallazgo principal:** 9 de 21 áreas reúnen al menos el 50 % de los delitos de cada sexo, una concentración moderada (con un reparto uniforme se necesitarían alrededor de 10.5). Las áreas coinciden en 6 de 9; Southwest, Southeast y Olympic aparecen solo para mujeres, y Topanga, West Valley y Wilshire solo para hombres.

**Pregunta 5:** ¿Qué áreas concentran el 50 % del principal delito de cada sexo, y cómo se comparan con el total de delitos?

**Hallazgo principal:** La violencia de pareja contra mujeres se concentra en el sur de la ciudad (77th Street, Southeast y Southwest) y requiere 8 áreas para alcanzar el 50 %; la lesión física simple contra hombres se concentra en Central y Hollywood. 77th Street y Newton son las únicas áreas presentes en todos los grupos de concentración. Los datos son cifras absolutas y no tasas por habitante, por lo que no permiten afirmar que un área sea más riesgosa que otra.

**Rutas de las figuras publicadas:**

- Pregunta 1: `docs/imgs/figura_01.png`
- Pregunta 2: `docs/imgs/figura_02.png`
- Pregunta 3: `docs/imgs/figura_03.png`
- Pregunta 4: `docs/imgs/figura_04.png`
- Pregunta 5: `docs/imgs/figura_05.png`

**Breve reflexión: ¿qué fue lo más difícil?, ¿qué hallazgo es más sólido y cuál más frágil?, ¿qué cambiarían con más tiempo?**

Lo más difícil fue construir las capas `clean` y `model` en SQL, ya que si no estaban bien escritas no se podían ejecutar en la terminal ni continuar con los pasos siguientes. La capa `clean` implicó explorar la base para identificar qué era necesario limpiar y bajo qué criterios, además de tener claras las preguntas para saber qué variables conservar. Uno de los principales retos fue transformar la fecha y la hora, que venían como texto y en formatos distintos, para unirlas en una sola variable de fecha y obtener a partir de ella la hora, el día de la semana y el año. También fue necesario definir criterios para dejar como vacíos los valores no válidos de sexo de la víctima (distintos de F, M o X) y de edad (fuera del rango de 1 a 99), así como decidir en qué capa aplicar el recorte del periodo 2020–2023: lo dejamos en `model` para que `clean` conservara la serie completa y el perfilado pudiera mostrar la caída de registros en 2024. De igual forma, la capa `model` requirió tener bien definidas las preguntas para saber qué información se quería mostrar en las gráficas.

El hallazgo más sólido es el de los delitos más frecuentes por sexo de la víctima, ya que se obtiene directamente del conteo de casos registrados, aunque con la limitación de considerar solo los registros con sexo bien clasificado como masculino o femenino. Aun así, muestra una diferencia clara entre hombres y mujeres en materia de incidencia delictiva. El más frágil es el de la concentración de delitos por área, porque se basa en cifras absolutas y no en tasas por habitantes, por lo que no permite comparar el riesgo entre áreas.

Con más tiempo se incorporarían datos de población por área para calcular tasas por cada 100 mil habitantes y comparar las áreas de forma más justa. También se podría analizar la concentración a una escala más fina, con las coordenadas de cada incidente; incorporar el tipo de lugar donde ocurrió el delito (variable `Premis Desc`) para poner a prueba las hipótesis sobre espacios residenciales y de actividad nocturna; e investigar el origen del pico de robo de identidad en 2022.
