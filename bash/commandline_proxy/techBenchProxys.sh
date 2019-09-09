#!/bin/bash

#unalProxy="http://proxy.unal.edu.co"
#Puerto="8080/proxy.pac"

read -p "usuario: " -r user
echo "pass: "
read -s password

proxy=proxyapp
#proxy=proxy

dominio=unal.edu.co

puerto=8080/proxy.pac
#puerto=8080
#puerto=111

varproxy=http://$user:$password@$proxy.$dominio:$puerto

echo "$varproxy"

http_proxy=$varproxy
https_proxy=$varproxy
ftp_proxy=$varproxy


#ftp_proxy=$user:$password@$unalProxy:$Puerto
#https_proxy=$user:$password@$unalProxy:$Puerto
#ftp_proxy=$user:$password@$unalProxy:$Puerto

export http_proxy
export https_proxy
export ftp_proxy

#echo "http_proxy: "$http_proxy
#echo "https_proxy: "$https_proxy
#echo "ftp_proxy: "$ftp_proxy

echo "Proxy para unal establecido."
echo ""
echo "A tener en cuenta:"
echo "1° Es necesario ejecutar el archivo de la siguiente manera:"
echo "	$ . techBenchProxys.sh"
echo "2° Pueda que deba ejecutarlo como SUPERADMINISTRADOR"
echo "	Para hacer uso del gestor de paquetes (apt.. aptituide)"
echo "	# . techBenchProxys.sh"
