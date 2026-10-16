# Reporte de exploración

## Integrantes

- Integrante A: Dulce Torres
- Integrante B: Guillermo Castillo

## Base de datos

Nombre:

Fuente: 

Descripción breve: 

## Exploración inicial

Pendiente. 

## Hallazgo del integrante A

Pendiente

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
