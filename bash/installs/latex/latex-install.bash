#!/bin/bash

install() {
	sudo apt update
	sudo apt install \
		texlive-latex-recommended \
		texlive-latex-extra \
		texlive-lang-spanish \
		texlive-fonts-extra \
		texlive-bibtex-extra \
		inkscape \
		-y
}

# install
