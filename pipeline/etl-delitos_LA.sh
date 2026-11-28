
# Pipeline para reproducir la tarea 4: de datos crudos a un reporte reproducible en Quarto


# 1. INSTALAR PROGRAMAS REQUERIDOS

# 1.1. UV: herramienta para gestionar proyectos de Python

curl -LsSf https://astral.sh/uv/install.sh | sh

# Verifica la instalación con:

uv --version

# 1.2. DUCKDB: modelo embebido

curl https://install.duckdb.org | bash

# 1.3. QUARTO: para generar página html

VERSION=$(curl -s https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/v//')
wget https://github.com/quarto-dev/quarto-cli/releases/download/v${VERSION}/quarto-${VERSION}-linux-amd64.deb
sudo dpkg -i quarto-${VERSION}-linux-amd64.deb
rm quarto-${VERSION}-linux-amd64.deb

#Verifica la instalación con:

quarto --version


# 2. CLONAR REPOSITORIO Y UBICARTE DENTRO DE ÉL

git clone https://github.com/dulcetorres220799/progra-gatos.git

cd progra-gatos


# 3. SINCRONIZAR EL ENTORNO DE PYTHON (para instalar librerías del proyecto)

uv sync


# 4. DESCARGAR BASE DE DATOS (guardándola dentro de raw)

curl -L "https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD" -o data/raw/delitos_LA.csv


# 5. EJECUTAR SCRIPTS DE SQL CON DUCKDB (en orden)

rm -f data/db/delitos_LA.duckdb

duckdb data/db/delitos_LA.duckdb -f sql/01_raw.sql

duckdb data/db/delitos_LA.duckdb -f sql/02_clean.sql

duckdb data/db/delitos_LA.duckdb -f sql/03_model.sql


# 6. ABRIR Y CORRER NOTEBOOKS EN VISUAL STUDIO (VS)

# 6.1. Abrir VS

code .

# 6.2. Ubicar la carpeta "notebooks", abrir notebook 1, seleccionar el kernel .venv en "Select Kernel", darle "Restart" y después "Run All"

notebooks/nb01_estructura_perfilado.ipynb

# 6.3. Ubicar la carpeta "notebooks", abrir notebook 2, seleccionar el kernel .venv en "Select Kernel", darle "Restart" y después "Run All"

notebooks/nb02_preguntas_visualizaciones.ipynb


# 7. RENDERIZAR EL REPORTE CON QUARTO PARA GENERAR HTML (esto ya es de regreso en la terminal, no en VS)

quarto render docs/reporte.qmd
