#!/bin/bash

update() {
	sudo apt update
	install
}

install() {
	sudo apt install \
		goldendict-ng \
		translate-shell \
		mpg123 \
		-y

}

trans() {
	sudo apt install libfribidi-bin
	wget -O translate-shell.deb "http://ftp.us.debian.org/debian/pool/contrib/t/translate-shell/translate-shell_0.9.7.1-2_all.deb"
	sudo dpkg -i translate-shell.deb
	rm translate-shell.deb
}

doc() {
	echo "Documentación oficial de goldendict-ng:
https://xiaoyifang.github.io/goldendict-ng/"
}

DDIC=~/gitPackages/goldendict-dic
dic() {
	mkdir -p $DDIC
	cd $DDIC
	wget http://www.ugr.es/~alozano/Babylon/AnEnglishSpanishDictionary.bgl
	wget http://www.ugr.es/~alozano/Babylon/ASpanishEnglishDictionary.bgl
}

config() {
	echo "Descargadas los diccionarios, abrir goldendict-ng y configurar
la ruta de los diccionarios accediendo a Edit->Dictionaries->Source->Files
Y desde allí agregar el PATH donde se instalaron los diccionarios:
$DDIC, seguido ejecutar la acción de 'Rescan now'
"
	echo "Para agregar la pronunciación agregar en Edit->Dictionaries->Sources->Programs un programa de Audio y poner nombre para su uso, agregar el siguiente comnado:
  bash -c \"p=\$(echo \"%GDWORD%\" |sed 's/ /+/g'); wget -q -U Mozilla -O - translate.google.com.vn/translate_tts?ie=UTF-8\&q=\$p\&tl=en\&client=tw-ob | mpg123 -\"
"
	echo "Para agregar la traducción de textos de inglés a español agregar en Edit->Dictionaries->Sources->Programs un programa de texto plano y poner nombre para su uso, agregar el siguiente comnado:
  trans -e google -s en -t es -show-original y -show-original-phonetics n -show-translation y -no-ansi -show-translation-phonetics n -show-prompt-message n -show-languages y -show-original-dictionary n -show-dictionary n -show-alternatives n \"%GDWORD%\"
"
	echo "Para agregar la traducción de textos de español a insglés agregar en Edit->Dictionaries->Sources->Programs un programa de texto plano y poner nombre para su uso, agregar el siguiente comnado:
  trans -e google -s es -t en -show-original y -show-original-phonetics n -show-translation y -no-ansi -show-translation-phonetics n -show-prompt-message n -show-languages y -show-original-dictionary n -show-dictionary n -show-alternatives n \"%GDWORD%\" 
"
}

help() {
	echo "
update
install
trans #Instalar manualmente translate-shell sino se encuentra en el source list de la distribución de debian
doc
config
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
