# Manual:
# https://just.systems/man/en/
# https://github.com/casey/just/tree/master/examples
# https://just.systems/man/en/functions.html?highlight=without#functions

BUILD_DIR := "build"
SRC := "template.tex"
BASE_NAME := without_extension(SRC)
COMPILER := "lualatex"
VIEWER := "pdfpc"

# VIEWER := "zathura"
# VIEWER := "evince"

pdf:
    mkdir -p {{ BUILD_DIR }}
    {{ COMPILER }} -output-directory={{ BUILD_DIR }} -shell-escape {{ SRC }}

view:
    {{ VIEWER }} {{ BUILD_DIR }}/{{ BASE_NAME }}.pdf

clean:
    rm -f {{ BUILD_DIR }}/*

# pdf: $(OBJ).tex
# 	mkdir -p (BUILD_DIR)
# 	$(COMPILER) -output-directory={{BUILD_DIR}} -shell-escape ./$(DOC).tex
# 	@echo "\nTamaño del documento pdf:"
# 	@ls -lh $(BUILD)/$(DOC).pdf
# view: $(BUILD)/$(DOC).pdf
# 	evince $(BUILD)/$(DOC).pdf
