path = static
doc = ebook

pdf: $(path)/$(doc).tex
	pdflatex -output-directory=build/ -shell-escape $(path)/$(doc).tex

view: build/$(doc).pdf
	evince build/$(doc).pdf

all: pdf view

init:
	mkdir src imag build
	touch src/section1.tex
	cp ~/basededatos/LaTeX/tareas/plantilla.tex $(doc).tex

clear:
	rm build/*
		
latex-v:
	evince ~/basededatos/libros/LaTeX/LaTeX_2014.pdf &

latex-simbol:
	gpicview ~/basededatos/LaTeX/imag/ &
