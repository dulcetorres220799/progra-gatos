# Reporte de exploración

## Integrantes

- Integrante A: Dulce Torres
- Integrante B: Guillermo Castillo

## Base de datos

Nombre: CRIME DATA

Fuente: https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?accessType=DOWNLOAD

Descripción breve: Es una base de datos sobre delitos de Los Angeles durante los últimos 5 años.

## Exploración inicial

Pendiente. 

## Hallazgo del integrante A

### Pregunta 

1. ¿Cuántos delitos se clasifican de tipo 1 y cuántos de tipo 2?
2. ¿Cuántos delitos de tipo 1 y 2 tienen cada una de las áreas?

### Comando

1. cut -d "," -f8 datos.csv | tail -n +2 | sort | uniq -c |
2. cut -d "," -f6,8 datos.csv | tail -n +2 | sort | uniq -c | sort -nr

### Resultado 

1. 602622 1
 402272 2

2. 43106 Central,1
  39510 Pacific,1
  35577 77th Street,1
  33297 Southwest,1
  31482 Hollywood,1
  30705 Wilshire,1
  30591 N Hollywood,1
  30298 Newton,1
  29967 Olympic,1
  28756 West LA,1
  28140 Southeast,1
  27762 Rampart,1
  26824 Northeast,1
  26562 Central,2
  26179 77th Street,2
  25425 Van Nuys,1
  25035 Devonshire,1
  24780 Topanga,1
  24348 West Valley,1
  24137 Southwest,2
  23734 Harbor,1
  22846 Mission,1
  22011 Hollenbeck,1
  21789 Southeast,2
  20947 Hollywood,2
  20515 N Hollywood,2
  20103 Olympic,2
  20003 Pacific,2
  19062 Rampart,2
  18875 Newton,2
  18428 Foothill,1
  17798 West Valley,2
  17658 Harbor,2
  17532 Wilshire,2
  17496 Mission,2
  17456 Van Nuys,2
  16969 West LA,2
  16708 Devonshire,2
  16585 Topanga,2
  16127 Northeast,2
  15070 Hollenbeck,2
  14701 Foothill,2


### Interpretación 

1. Mi comando pide lo siguiente: selecciona, donde el delimitador es una coma, mis campo (columna) 8 de la base, luego quita el encabezado, luego ordena, luego cuenta los valores únicos.
La interpretación es que hay 602,622 delitos del tipo 1 y 402,272 del tipo 2. En total, hay más delitos del tipo 1 en la base. 
2. Mi comando pide lo siguiente: selecciona, donde el delimitador es una coma, mis campos (columnas) 6 y 8 de la base, luego quita el encabezado, luego ordena, luego cuenta los valores únicos, y luego ordena de mayor a menor. 
Lo que destaca de la interpretación es que que la zona Central tiene la mayor cantidad de delitos del tipo 1, y Foothill la menor cantidad del tipo 2.

## Hallazgo del integrante B

### Pregunta
¿Cuáles son los principales delitos que son reportados en Los Angeles? 

### Comando
'''bash

tail -n +2 datos.csv | cut -d',' -f10 | sort | uniq -c | sort -nr | less

### Resultado
Los principales delitos reportados en Los Angeles son: 
Robo de vehículo
Lesiones simples
Robo dentro del vehículo
Robo de identidad
Vandalismo - daños a la propiedad

### Interpretación
A partir de la selección de la columna 10, referente a la descripción del delito,
se obtuvo el listado de delitos ordenados de mayor a menor, según su frecuencia. 
De manera que el principal delito cometido en Los Angeles corresponde a robo de vehículo,
con 115,184 registros para el periodo de la base de datos. 

## Conclusión del equipo

ESTADO_CONCLUSION: PENDIENTE

## Reflexión sobre Git

Pendiente. 
