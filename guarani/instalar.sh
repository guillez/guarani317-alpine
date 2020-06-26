#!/bin/sh

	source /data/cfg/variables
	
	svn checkout ${URL_DOWNLOAD} ${DIR_SISTEMA} --username ${COLAB_USUARIO} --password ${COLAB_CLAVE}

	chmod 777 /data/local/g3gestion -R
	
	cd /data/local/g3gestion
	
	#composer install --prefer-dist
	#Para poder solucionar problemas de incompatibilidad se debe ejecutar composer con los parametros
	composer install --prefer-dist --ignore-platform-req=composer-plugin-api
	
	### Toba
	cd bin
	export TOBA_INSTANCIA=desarrollo
	export TOBA_INSTALACION_DIR=/data/local/g3gestion/instalacion
	./toba instalacion instalar

	### Cambiar permisos post instalacion de Toba
	chown -R apache:apache /data/local/g3gestion/www
	chown -R apache:apache /data/local/g3gestion/temp
	chown -R apache:apache /data/local/g3gestion/instalacion
	chown -R apache:apache /data/local/g3gestion/metadatos_compilados
	chown -R apache:apache /data/local/g3gestion/vendor/siu-toba/framework/www
	chown -R apache:apache /data/local/g3gestion/vendor/siu-toba/framework/temp

	### Agregar los parámetros en el archivo de inicialización de la instalación Toba
	###link virtuales
	ln -s /data/local/g3gestion/instalacion/toba.conf /etc/apache2/conf.d/gestion.conf
        
	### Agregar los parámetros en el archivo de inicialización de la instalación Toba
	### (<path proyecto Guaraní>/lib/toba/instalacion/instalacion.ini): 
	echo "[xslfo]" >> /data/local/g3gestion/instalacion/instalacion.ini
	echo /data/local/g3gestion/php/3ros/fop/fop  >> /data/local/g3gestion/instalacion/instalacion.ini

	### Cargar el proyecto, dentro de la carpeta 'bin' de Guaraní (<path proyecto Guaraní>/bin)
	cd /data/local/g3gestion/bin
	./guarani cargar -d /data/local/g3gestion
	
	cd /data/local/g3gestion/bin
	./guarani instalar

	
