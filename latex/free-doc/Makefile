doc = free-doc-example

pdf: $(doc).tex
	pdflatex -output-directory=build/ -shell-escape $(doc).tex

view: build/$(doc).pdf
	evince build/$(doc).pdf

all: pdf view

init:
	mkdir src img build
	touch srcontent.tex

clear:
	rm build/*
		
latex-v:
	evince ~/basededatos/libros/LaTeX/LaTeX_2014.pdf &

latex-simbol:
	gpicview ~/basededatos/LaTeX/imag/ &
