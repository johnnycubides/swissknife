# Goldendict

## Comandos de uso

|Comando|Descripción|
|:-------------:|:-------------:|
|^CC| El texto seleccionado será traducido|
|Alt+s| Escuchar traducción de palabra|



## Instalación

```bash
sudo apt install goldendict translate-shell mpg123
```

## Ajustes

### Usando el traductor de google

Abre la aplicación **goldendict** y em la barra de menú buscar: 
**Edit -> Dictionaries -> Sources -> Programs** y agregar un nuevo programa

#### Traducción de Ingles a Español

Adicionar la siguiente información al programa adicionado:

* Enable: check
* Type: Plain Text
* Name: Gtrans EN-ES
* Command Line:

```bash
trans -e google -s en -t es -show-original y -show-original-phonetics n -show-translation y -no-ansi -show-translation-phonetics n -show-prompt-message n -show-languages y -show-original-dictionary n -show-dictionary n -show-alternatives n "%GDWORD%"
```

#### Traducción de Español a Inglés

Adicionar la siguiente información al programa adicionado:

* Enable: check
* Type: Plain Text
* Name: Gtrans ES-EN
* Command Line:

```bash
trans -e google -s es -t en -show-original y -show-original-phonetics n -show-translation y -no-ansi -show-translation-phonetics n -show-prompt-message n -show-languages y -show-original-dictionary n -show-dictionary n -show-alternatives n "%GDWORD%" 
```

### Pronunciación desde Mozilla

Dependencia: mpg123

Adicionar la siguiente información al programa adicionado:

* Enable: check
* Type: Audio
* Name: Pronunciación
* Command Line:

```bash
bash -c "p=$(echo "%GDWORD%" |sed 's/ /+/g'); wget -q -U Mozilla -O - translate.google.com.vn/translate_tts?ie=UTF-8\&q=$p\&tl=en\&client=tw-ob | mpg123 -"
```
