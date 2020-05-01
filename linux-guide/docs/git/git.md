# Ayuda para manejar GIT

## Hacer pull

###Verificación de branches actualizados

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

### Renombrando path de submódulo

[stackoverflow](https://stackoverflow.com/questions/4526910/rename-a-git-submodule)

* Update .gitmodules
* mv oldpath newpath
* git rm oldpath
* git add newpath
* git submodule sync

## Creando un branch huérfano

En un repositorio ya creado, para iniciar un branch huérfano vea el
siguiente ejemplo:

```bash
git checkout --orphan new_branch_orphan
git rm -rf .
mkdir new_branch_orphan
touch new_branch_orphan/README.md
git add new_branch_orphan/
git commit -m "init branch"
git push origin new_branch_orphan
```

