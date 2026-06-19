f := "file.pu"
BASENAME := file_stem(f)

# Target por defecto
default: help

help:
    @just --list

plantumlSVG:
    @echo "Generar svg desde código plantuml"
    @echo "usar f=file sin la extensión .pu"
    plantuml -tsvg {{ BASENAME }}.pu

bgWhite:
    sed -i '0,/<defs/s/<defs/<rect width="100%" height="100%" fill="#ffffff" stroke="none"\/><defs/' {{ BASENAME }}.svg

svgtopdf:
    inkscape {{ BASENAME }}.svg --export-filename={{ BASENAME }}.pdf || \
    inkscape {{ f }} --export-filename={{ BASENAME }}.pdf

rmsvg:
    @echo "remover {{ BASENAME }}.svg"
    rm -f {{ BASENAME }}.svg

plantumlPDF: plantumlSVG svgtopdf rmsvg

rmpdf:
    @echo "remover {{ BASENAME }}.pdf"
    rm -i {{ BASENAME }}.pdf || rm -i {{ f }}

view:
    eog {{ BASENAME }}.sv
