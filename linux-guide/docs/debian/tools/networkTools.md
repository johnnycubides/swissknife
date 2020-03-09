# Herramientas para redes

## Encontrar ips conectadas a la red

```bash
sudo nmap -sP <ip>-254
```

## Verificar estado de puertos

[fuente](https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/)

```bash
nmap <ip> -p <port> | grep -i tcp
nc -zv <ip> <port>
netstat -tulpn | grep LISTEN
lsof -i -P -n | grep LISTEN
lsof -i:<port>
```
