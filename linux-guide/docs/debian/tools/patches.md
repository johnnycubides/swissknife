# Parches

|**diff** opciones|Descripción|
|:-------------:|:-------------:|
|-r | Recursivo |
|-u | Crear un archivo|
|-N | Tratar los archivos ausentes como vacíos|

|**patch** opciones|Descripción|
|:-------------:|:-------------:|
|-R | Revertir cambios |
|-p0 |Aplique el parche a la misma estructura de directorio que cuando se creó el parche |

# Parches a archivos

* Crear parche

```bash
diff -u OriginalFile UpdatedFile > PatchFile
```

* Aplicar parche a un archivo

```bash
patch OriginalFile < PatchFile
```
*Deshacer parche a un archivo

```bash
patch -R OriginalFile < PatchFile
```

# Parche a directorios

* Crear parche a directorio

```bash
diff -ruN OriginalDir UpdatedDir > PatchFile
```

* Aplicar parche a directorio

```bash
patch -p0 < PatchFile
```

* Remover parche a directorio

```bash
patch -R -p0 OriginalFile < PatchFile
```
