#!/bin/bash
path_plantuml=~/gitPackages/plantuml
path_java=/usr/bin/java
doc_viewer=evince
img_viewer=eog

printf "=======================\n"
printf "PLANTUML  \n"
printf "=======================\n"

if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
    printf "Help for this command plantuml\n"
    printf "\t-c\tcreate graph\n"
    printf "\t-cv\tcreate graph and view\n"
    printf "\t-h\thelps\n"
    printf "\t[format_out]\tpng svg eps\n"
    printf "How use\n"
    printf "\tplantuml.sh -cv file_in format_out\n"
    printf "Example to use\n"
    printf "\tplantuml.sh -c file.pu png\n"
    printf "\tplantuml.sh -cv file.pu eps\n"
    printf "\tplantuml.sh -v file.pu svg\n\n"
elif [ "$1" = "-c" ] # Crear el grafo
then
    printf "Creating graph\n"
    $path_java -jar $path_plantuml/plantuml.jar -t$3 $2
elif [ "$1" = "-v" ] #Ver grafo
then
    if [ "$3" = "eps" ]
    then
        $doc_viewer "${2/.pu/.$3}"& #Sustitución de subcadenas, debe escogerse el visor por defecto
    else
        $img_viewer "${2/.pu/.$3}"& #Sustitución de subcadenas, debe escogerse el visor por defecto
    fi
elif [ "$1" = "-cv" ] #Crear grafo y ver
then
    printf "Creating graph\n"
    $path_java -jar $path_plantuml/plantuml.jar -t$3 $2
    printf "graph graph\n"
    if [ "$3" = "eps" ]
    then
        $doc_viewer "${2/.pu/.$3}"& #Sustitución de subcadenas, debe escogerse el visor por defecto
    else
        $img_viewer "${2/.pu/.$3}"& #Sustitución de subcadenas, debe escogerse el visor por defecto
    fi
else
    printf "Did not select valid option\n"
fi

printf "Regards Johnny\n"
