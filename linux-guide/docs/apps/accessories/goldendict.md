# Goldendict

## Instalación

```bash
sudo apt install goldendict
```

## Ajustes

### Usando el traductor de google

En la barra de menú buscar: **Edit -> Sources -> Programs** y agregar un nuevo programa

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

```bash
sudo apt install mpg123
```

Adicionar la siguiente información al programa adicionado:

* Enable: check
* Type: Audio
* Name:
* Command Line:

```bash
bash -c "p=$(echo "%GDWORD%" |sed 's/ /+/g'); wget -q -U Mozilla -O - translate.google.com.vn/translate_tts?ie=UTF-8\&q=$p\&tl=en\&client=tw-ob | mpg123 -"
```
