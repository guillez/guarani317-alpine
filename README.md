#DOCKER-COMPOSE GUARANI

#CONTENIDO

- docker postegres (postgres)
- docker guarani (guarani) <- nombre configurado en dockerfile

#EJECUCION

docker-compose up -d 

#VOLUMENES

/guarani317_volumen -> carpeta que contendria el sistema (configurable por variable)
/pg_volumen -> carpeta de base de datos postgres (configurable por variable)

#POST CONSTRUCCION DE CONTENEDORES

#ingresar al contenedor guarani

docker exec -ti guarani bash

#dependiendo el caso (instalacion / restauracion) acceder a /app

cd /data/cfg

# si se desea instalar el entorno ejecutar

# IMPORTANTE: en la carpeta /guarani317_volumen se debe bajar el repositorio de Guarani de Colab

# este tiene que tener la estructura siguiente: /data/local/g3gestion/  

# en esta carpeta debe estar el proyecto. En la carpeta /data/cfg se encuentran 

# varibales(son los datos de acceso a colab) - instalar.sh es el archivo que permite la isntalacion del sistema

# el archivo .env del raiz contiene variables de configuracion de apache y postgres

EJECUCION POST INSTALACION DESDE LA CARPETA /data/cfg
-------------------------------------------------------------

./instalar.sh -> el bash solicita datos de configuraciones

-------------------------------------------------------------

Nombre del Alias (por defecto "toba"): 
Por favor, ingrese su n�mero de desarrollador (ENTER utilizar� 0): 718
Se trata de una instalacion de producci�n? (Si o No)(s/n):  n
Nombre de la instalaci�n (ej: Andromeda): : guarani
PostgreSQL - Ubicaci�n (ENTER utilizar� localhost): postgres
PostgreSQL - Puerto (ENTER utilizar�: 5432): 
PostgreSQL - Usuario (ENTER utilizar� postgres): 
PostgreSQL - Clave  (ENTER para usar sin clave): postgres
PostgreSQL - Base de datos (ENTER utilizar� toba_3_0): 
Nombre del schema a usar (ENTER utilizar� desarrollo): 
Toba - Clave (usuario "toba"): toba
sobrescribe la actual  (enter) <- OJO si tenes una base actual
Ya existe el modelo de datos, Desea reemplazarlo? (borra la base completa y la vuelva a cargar) (Si o No)(s/n): s
Desea agregar el alias de apache al archivo toba.conf? (Si o No)(s/n): s

-------------------------------------------------------------

#si se desea solo restaurar el docker , en caso de tener la carpeta /data_des con el sistema

./restaurar.sh -> este solo agrega en apache la configuracion del sistema

#En uno de los pasos muestra el mensaje siguiente
#Desea conservar datos locales como usuarios y logs? (Si o No) -> Se indico la opcion n
 
#Editar archivo bases.ini agregando lineas siguientes (Carpeta /data/local/g3gestion/instalacion)

[desarrollo guarani guarani]
motor = "postgres7"
profile = "postgres"
usuario = "postgres"
clave = "postgres"
puerto = "5432"
encoding = "LATIN1"
base = "toba_3_0"
schema = "negocio"



# IMPORTANTE: LUEGO DE REINICIADO EL CONTENEDOR SE PUEDEN ACCEDER A LAS URLS ABAJO MENCIONADAS
# si falla jasper se puede ejecutar en /app/jasper.sh 

# acorde a los puertos configurados se puede acceder a

#http://localhost:7081/toba_editor/3.0/aplicacion.php
#http://localhost:7081/guarani/3.16/

# EN .env se encuentran configuraciones del docker-compose y en la carpeta /guarani estan las del docker específico


