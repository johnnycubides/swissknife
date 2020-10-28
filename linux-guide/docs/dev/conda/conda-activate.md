# Conda variables

## crear archivo

* `touch ~/.conda-vars.sh`

Insertar el siguiente contenido

```bash
echo '
#>>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/johnny/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/johnny/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/johnny/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/johnny/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# Default evr conda
conda activate fpga
# conda activate base
export PATH=~/.local/bin:"$PATH"
' >> ~/.conda-vars.sh

```

## Correr las variables de conda

`. ~/.conda-vars.sh`

## Observaciones

En éste ejemplo se propone hacer uso de la variable de entorno **fpga**, depende de lo
que estés usando modificar la variable de entorno.
