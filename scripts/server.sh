echo A
rm -rf ./jdk-21.0.5+11
echo B
tar -xf OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz  -C .
echo C
sudo ufw allow $1
echo D
kill $(pgrep -f "java -jar Facturas-0.0.1-SNAPSHOT.jar --server.port=$1")
echo E
nohup ./jdk-21.0.5+11/bin/java -jar Facturas-0.0.1-SNAPSHOT.jar --server.port=$1 > app-$1.log 2>&1 &
echo F

