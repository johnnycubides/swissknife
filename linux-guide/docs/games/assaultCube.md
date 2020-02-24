# Assault Cube

## Instalación

### 1. Clonar repositorio

```bash
git clone -b master --single-branch https://github.com/assaultcube/AC.git
```

### 2. Instalando dependencias

```bash
sudo apt install libopengl-dev libsdl-dev libsdl-image1.2-dev zlib1g-dev libogg-dev libvorbis-dev libopenal-dev 
```

**caution**: openAL error (A003): invalid value, line 156

### 3. Compilando e instalando

```bash
cd AssaultCube/AC/source/src
make install
```

### 4. Ejecutando

```bash
cd AssaultCube
./assaultcube.sh
```
