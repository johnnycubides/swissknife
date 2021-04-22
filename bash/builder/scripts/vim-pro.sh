PATH_PRJ_VIM_TEMPLATE="vim/prjTemplates"
# init vim projects
init_provim(){
    # Permite guardar información acerca de comandos usados
    printf "Se creará un script que configura a nvim con algunas características\n"
    printf "orientadas al lenguaje de programación que esté usando, el archivo creado\n"
    printf "se llamará pro.vim, este archivo se ejecutará siempre que abra nvim en el\n"
    printf "el directorio que contiene ese archivo. Cuando entre a nvim, oprima F1 para\n\n"
    printf "\n\tTIPO DE PROYECTO\n\n"
    printf "\t\t1 -> C, C++\n"
    printf "\t\t2 -> vue\n"
    printf "\t\t3 -> ts, js\n"
    printf "\t\t4 -> java\n"
    printf "\t\t10 -> indefinido\n"
    printf "\t\t\n"
    read -p "Escoje una opción: " -r provim_selected
    
    if [ "$provim_selected" = "1" ];
    then
        provim_selected="c-pro.vim"
    elif [ "$provim_selected" = "2" ];
    then
        provim_selected="vue-pro.vim"
    elif [ "$provim_selected" = "3" ];
    then
        echo "Opción aún no creada"
        provim_selected="ts-pro.vim"
        exit 0
    elif [ "$provim_selected" = "4" ];
    then
        provim_selected="java-pro.vim"
    elif [ "$provim_selected" = "10" ];
    then
        provim_selected="pro.vim"
    else
        echo "Opción inválida"
        exit 0
    fi
    cp $PATH_SWISSKNIFE/$PATH_PRJ_VIM_TEMPLATE/$provim_selected ./pro.vim
    echo "Script $provim_selected creado,"
    echo "Regards Johnny!"
}
