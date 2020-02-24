# Ayuda para manejar GIT

## Hacer pull

###Veridicación de branches actualizados

[Fuente](https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git)

El siguiente comando verificará si todos los braches están al día

```bash
git remote -v update
```

Verificar si el repositorio local esta update:

```bash
git remote update
```

El siguiente comando le dirá si la rama que está rastreando está: [adelante, atrás,  ha divergido];
**sino dice nada**, el repositorio local y el remoto estan **sincronizados**

```bash
git status -uno
```

## Clonando un único branch

```bash
git clone -b nameBranch --single-branch url_git_repo
```

## Submódulos

### Creando

[Fuente](https://riptutorial.com/git/example/1075/cloning-a-git-repository-having-submodules)

```bash
git submodule add https://github.com/johnnycubides/imx23-olinuxino.git
```

