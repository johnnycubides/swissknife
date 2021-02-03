# Instalación de NODEJS

[Fuente](https://github.com/nvm-sh/nvm)

### Descargar y ejecutar el script de instalación

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
```

### Reiniciar .bashrc

```bash
source ~/.bashrc
```

### Verificación de instalación del script

```bash
command -v nvm
```

### Instalación y actualización de nodeJS

```bash
nvm install node
```

### Comandos

|Comando|Descripción|
|:-------------:|:-------------:|
|nvm install --lts|Instalar una versión LTS|
|nvm use x.x.x|Intercambiar entre versiones de node|
|nvm use node|Usar la última version instalada de node|
|nvm ls|listar las versiones instaladas de node|
|nvm current|revisar la versión de node que está en uso|
|nvm uninstall x.x.x|Desinstalar una versión de node|
|||

