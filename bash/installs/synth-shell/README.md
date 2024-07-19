---
lang: es
---

# Synth Shell

Lo primero que hay que aclarar es que está en esperimientación por mi cuenta y que requiere algunas intervenciones para su uso

* [Página principal](https://github.com/andresgongora/synth-shell)

Comando de instalación:

Requiere la instalación de powerline-shell

```bash
sudo apt install fonts-powerline
```

```bash
git clone --recursive https://github.com/andresgongora/synth-shell.git
chmod +x synth-shell/setup.sh
cd synth-shell
./setup.sh
```

Cuando se inicia el proceso de instalación indica que puede instalar varias herramientas,
por ahora, no las requiero, además agrega ruido innecesario, por tanto solo instalo el prompt y
alguna que otra de interés como es el caso de history o alias.

Cuando se ha instalado se debe hacer una configuración manual en el directorio

```bash
~/.config/synth-shell/synth-shell-prompt.config
```

La cual se encuentra en este directorio.

Para quitar el efecto de bold en el prompt sin afectar las demás características he modificado las siguientes líneas
agregando el condicional if, else en esa función.

Archivo a afectar:

```bash
~/.config/synth-shell/synth-shell-prompt.sh
```

```bash
  printSegment() {
    ## GET PARAMETERS
    local text=$1
    local font_color=$2
    local background_color=$3
    local next_background_color=$4 # needed for the separator, it participates in this and the next text segment
    local font_effect=$5
    ## COMPUTE COLOR FORMAT CODES
    local no_color="\[$(getFormatCode -e reset)\]"
    if [[ "$font_effect" == "normal" ]]; then
      local text_format="\[$(getFormatCode -c $font_color -b $background_color)\]"
    else
      local text_format="\[$(getFormatCode -c $font_color -b $background_color -e $font_effect)\]"
    fi
    local separator_format="\[$(getFormatCode -c $background_color -b $next_background_color)\]"
    ## GENERATE TEXT
    printf "${text_format}${segment_padding}${text}${segment_padding}${separator_padding_left}${separator_format}${separator_char}${separator_padding_right}${no_color}"

```

Como lo indiqué es una prueba, aún uso powerline-shell, pero hay que revisar la versión de python compatible ya que las fuentes generar errores de sintaxis con la versión
de python 3.12..
