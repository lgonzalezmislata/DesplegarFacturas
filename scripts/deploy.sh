#!/bin/bash
source ./global/app.env
source ./entornos/$1


#Hacer el build
cd ..
rm -rf Facturas
git clone $URL_SOURCE_GIT
cd Facturas
git switch $RAMA_GIT
echo $(pwd)
mvn clean install
cd ../DesplegarFacturas

#Copiar los ficheros al servidor

#Reconstruir el fichero del JDK porque está en varias partes porque no deja subirlo entero
cat ./dependencies/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz_* > ./dependencies/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz


scp -i ./certificados/id_rsa ./dependencies/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz $USER_NAME@$IP_SERVER:.
rm ./dependencies/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz
scp -i ./certificados/id_rsa ./scripts/server.sh $USER_NAME@$IP_SERVER:.
scp -i ./certificados/id_rsa ../Facturas/target/Facturas-0.0.1-SNAPSHOT.jar $USER_NAME@$IP_SERVER:.

#Ejecutar el script
ssh -i ./certificados/id_rsa $USER_NAME@$IP_SERVER "./server.sh $APP_PORT"
