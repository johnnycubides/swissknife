# Documentación de usuario para VIM

|**Comando**|**Característica**|**Observación**|
|:-------------:|:-------------:|:-----:|
|bwy  | Copiar una palabra | |
|%  | Busca matches entre {}[]()| Si usa **v%** seleccionará el código que encierra |
|:e | Recargar un archivo en el buffer| |

## Comando básicos de vim bootstrap


Commands | Descriptions
--- | ---
`:cd <path>` | Open path */path*
<kbd>Ctrl</kbd><kbd>w</kbd>+<kbd>h</kbd><kbd>j</kbd><kbd>k</kbd><kbd>l</kbd> | Navigate via split panels
<kbd>Ctrl</kbd><kbd>w</kbd><kbd>w</kbd> | Alternative navigate vim split panels
<kbd>,</kbd><kbd>.</kbd> | Set path working directory
<kbd>,</kbd><kbd>w</kbd> or <kbd>,</kbd><kbd>x</kbd> | Next buffer navigate
<kbd>,</kbd><kbd>q</kbd> or <kbd>,</kbd><kbd>z</kbd> | previous buffer navigate
<kbd>shift</kbd><kbd>t</kbd> | Create a tab
<kbd>tab</kbd> | next tab navigate
<kbd>shift</kbd><kbd>tab</kbd> | previous tab navigate
<kbd>,</kbd><kbd>e</kbd> | Find and open files
<kbd>,</kbd><kbd>b</kbd> | Find file on buffer (open file)
<kbd>,</kbd><kbd>c</kbd> | Close active buffer (clone file)
<kbd>F2</kbd>  | Open tree navigate in actual opened file
<kbd>F3</kbd>  | Open/Close tree navigate files
<kbd>F4</kbd> | List all class and method, support for python, go, lua, ruby and php
<kbd>,</kbd><kbd>v</kbd> | Split vertical
<kbd>,</kbd><kbd>h</kbd> | Split horizontal
<kbd>,</kbd><kbd>f</kbd> | Search in the project
<kbd>,</kbd><kbd>o</kbd> | Open github file/line (website), if used git in **github**
<kbd>,</kbd><kbd>s</kbd><kbd>h</kbd> | Open shell.vim terminal inside Vim or NeoVim built-in terminal
<kbd>,</kbd><kbd>g</kbd><kbd>a</kbd> | Execute *git add* on current file
<kbd>,</kbd><kbd>g</kbd><kbd>c</kbd> | git commit (splits window to write commit message)
<kbd>,</kbd><kbd>g</kbd><kbd>s</kbd><kbd>h</kbd> | git push
<kbd>,</kbd><kbd>g</kbd><kbd>l</kbd><kbd>l</kbd> | git pull
<kbd>,</kbd><kbd>g</kbd><kbd>s</kbd> | git status
<kbd>,</kbd><kbd>g</kbd><kbd>b</kbd> | git blame
<kbd>,</kbd><kbd>g</kbd><kbd>d</kbd> | git diff
<kbd>,</kbd><kbd>g</kbd><kbd>r</kbd> | git remove
<kbd>,</kbd><kbd>s</kbd><kbd>o</kbd> | Open Session
<kbd>,</kbd><kbd>s</kbd><kbd>s</kbd> | Save Session
<kbd>,</kbd><kbd>s</kbd><kbd>d</kbd> | Delete Session
<kbd>,</kbd><kbd>s</kbd><kbd>c</kbd> | Close Session
<kbd>></kbd> | indent to right
<kbd><</kbd> | indent to left
<kbd>g</kbd><kbd>c</kbd> | Comment or uncomment lines that {motion} moves over
<kbd>Y</kbd><kbd>Y</kbd> | Copy to clipboard
<kbd>,</kbd><kbd>p</kbd> | Paste
<kbd>Ctrl</kbd><kbd>y</kbd> + <kbd>,</kbd> | Activate Emmet plugin
<kbd>Ctrl</kbd><kbd>h</kbd> | Does a fuzzy search in your command mode history
</details>

## VIFM

https://fossbytes.com/vifm-beginner-tutorial-file-manager-gnu-linux/

