# VENV := ". ~/gitPackages/zephyr/.vsphinx/bin/activate &&"

VENV := ". ~/miniconda3/etc/profile.d/conda.sh && conda activate sphinx &&"
VIEWER := "zathura"
PDF := "tallerdeingenieraelectrnicaunal.pdf"

server:
    civetweb -document_root ./build/html/ -listening_ports 3000

# Make pdf doc
pdf:
    {{ VENV }} make latexpdf

view:
    {{ VIEWER }} ./build/latex/{{ PDF }}

# Make html static page
html:
    {{ VENV }} make html

## Dependencies
# pip install sphinx-book-theme
# pip install sphinxcontrib-svg2pdfconverter
