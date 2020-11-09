# Compilación de OBS

[Referencia oficial de instalación](https://github.com/obsproject/obs-studio/wiki/install-instructions#debian-based-build-directions)

Dependencias

```bash
sudo apt install \
   build-essential \
   checkinstall \
   cmake \
   git \
   libmbedtls-dev \
   libasound2-dev \
   libavcodec-dev \
   libavdevice-dev \
   libavfilter-dev \
   libavformat-dev \
   libavutil-dev \
   libcurl4-openssl-dev \
   libfdk-aac-dev \
   libfontconfig-dev \
   libfreetype6-dev \
   libgl1-mesa-dev \
   libjack-jackd2-dev \
   libjansson-dev \
   libluajit-5.1-dev \
   libpulse-dev \
   libqt5x11extras5-dev \
   libspeexdsp-dev \
   libswresample-dev \
   libswscale-dev \
   libudev-dev \
   libv4l-dev \
   libvlc-dev \
   libx11-dev \
   libx264-dev \
   libxcb-shm0-dev \
   libxcb-xinerama0-dev \
   libxcomposite-dev \
   libxinerama-dev \
   pkg-config \
   python3-dev \
   qtbase5-dev \
   libqt5svg5-dev \
   swig \
   libxcb-randr0-dev \
   libxcb-xfixes0-dev \
   libx11-xcb-dev \
   libxcb1-dev \
   libxss-dev

```
**Observacion**: algunas de las anteriores dependencia requiere fuentes non-free,\
las cuales deben ser agregadas en `/etc/apt/sources.list`; para generar los sources
puede consultar en
[source list generador](https://debgen.simplylinux.ch/)
Seguramente le pediran instalar las siguientes dependencias `curl wget apt-transport-https dirmngr`

```bash
cd ~/gitPackages/
git clone --recursive https://github.com/obsproject/obs-studio.git
cd obs-studio/
mkdir build && cd build
cmake -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX=/usr ..
make -j4
sudo checkinstall --default --pkgname=obs-studio --fstrans=no --backup=no --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
```

!!! Info "Si en el último paso no permite la instalación por un tema referente a libobs ejecute sudo apt purge libobs (libobs0) y vuelva a ejecutar el último comando"
    

