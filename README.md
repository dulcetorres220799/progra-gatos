## Nombre del equipo:
 gatos

## Nombre de los integrantes: 
Dulce Torres
Guillermo Castillo

## Descripción breve de la base de datos
La base de datos contiene los delitos reportados en Los Angeles, California. 
Dicha base contiene registros de 2020 a 2025. 
El peso del archivo es de 244MB, con un total de 1,004,895 líneas, es decir, 1,004,894 registros. 
Los nombres de las columnas son: 
DR_NO,Date Rptd,DATE OCC,TIME OCC,AREA,AREA NAME,Rpt Dist No,Part 1-2,Crm Cd,Crm Cd Desc,Mocodes,Vict Age,Vict Sex,Vict Descent,Premis Cd,Premis Desc,Weapon Used Cd,Weapon Desc,Status,Status Desc,Crm Cd 1,Crm Cd 2,Crm Cd 3,Crm Cd 4,LOCATION,Cross Street,LAT,LON


## Fuente de los datos
https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD

## Instrucciones para descargar los datos
Para descargar los datos, utilice el siguiente comando: 
curl -L "https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD" -o data/datos.csv

## Descripción brevel del análisis
Este primer ejercicio consistió en conocer cuáles eran los principales tipos de delitos, 
el número de cada tipo de delito y las áreas donde ocurren. 

## Ubicación del reporte final 
docs/reporte.md

