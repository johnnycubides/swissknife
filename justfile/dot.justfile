f := "file.dot"

alias b := build
alias v := view

help:
    @printf "just f=file.dot build\n"
    @printf "just f=file.dot view\n"

build:
    dot -Tsvg {{ f }} -o {{ f }}.svg

view:
    open {{ f }}.svg
