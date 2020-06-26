#!/bin/bash

./guarani instancia_exp_local

cd /data/local/g3gestion

composer install

cd /data/local/g3gestion/bin

./toba instancia regenerar -i desarrollo

./guarani migrar_base

./guarani compilar
