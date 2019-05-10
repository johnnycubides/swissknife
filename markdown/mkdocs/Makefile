help:
	@printf "########################\n"\
	"#        MKDOCS        #\n"\
	"########################\n\n"\
	"Éste directorio \"docs/\" es de documentación "\
	"el cual está escrito en markdown y puede ser compilado para html.\n\n"\
	"Instrucciones:\n"\
	"1°: Debe tener instalado mkdocs.\n"\
	"\tlink oficial: https://www.mkdocs.org/\n"\
	"\tlink github: https://github.com/mkdocs/mkdocs\n"\
	"\n"\
	"Comandos:\n\n"\
	"\tserve:\tInicia un servidor web dinámico para la previsualización\n"\
	"\tview:\tMuestra una vista HTML previa en el navegador\n"\
	"\tbuild:\tConstruye HTML definitivo para empotrar en algún servidor web\n"\
	"\tclear:\tBorra contenido en el directorio build/\n\n"\
	"Atentos saludos:\n"\
	"\tEquipo Catalejo+\n"

serve:
	mkdocs serve

view:
	x-www-browser localhost:8000
	@printf "Sino se ha lanzado el navegador con el contenido "\
	"everifique que en otra terminal este corriendo el comando serve (make serve) "\
	"y luego refresque el navegador (F5).\n"

build:
	mkdocs build

clean:
	rm -rf build/*
