doc = circuit_name_sch
sim = $(doc).ngsim

schema:
	gschem $(doc).sch &

load-circuit-in-ngspice:
	ngspice -i $(doc).cir

load-circuit-in-ngspice-op:
	ngspice -i $(doc).cir $(doc).op

sim-op:
	ngspice -i $(doc).cir $(doc).op $(sim)

option-g:
	touch $(doc).op
	@echo ".control" >> $(doc).op
	@echo "set hcopydevtype=postscript" >> $(doc).op
	@echo "set hcopypscolor=1" >> $(doc).op
	@echo "set color0 = rgb:0/0/0" >> $(doc).op
	@echo "set color1 = rgb:f/f/f" >> $(doc).op
	@echo "set color2 = rgb:f/0/0" >> $(doc).op
	@echo "set color3 = rgb:0/f/0" >> $(doc).op
	@echo "set color4 = rgb:0/0/f" >> $(doc).op
	@echo "set color5 = rgb:f/f/0" >> $(doc).op
	@echo "set color6 = rgb:0/f/f" >> $(doc).op
	@echo "set color7 = rgb:f/0/f" >> $(doc).op
	@echo "set color8 = rgb:6/f/6" >> $(doc).op
	@echo "set color9 = rgb:9/f/9" >> $(doc).op
	@echo "op" >> $(doc).op
	@echo "display" >> $(doc).op
	@echo ".endc" >> $(doc).op

option-r:
	rm $(doc).op

circuit-g:
	gnetlist -o $(doc).cir -g spice-sdb $(doc).sch

circuit-r:
	rm $(doc).cir

circuit-v:
	less $(doc).cir

circuit-e:
	vim $(doc).cir

sim-e:
	vim -O $(doc).cir $(sim)

ps-rename:
	mv hc* $(doc).ps
view-ps:
	evince *.ps

convert-eps:
	ps2eps -B -f *.ps

ngspice-py:
	~/basededatos/simuladores/ngspice-gEDA/ngspice/sim_ngspice.py

view-ngspice:
	evince ~/basededatos/libros/spice/ngspice.pdf &

help:
	@printf \
	"view-ngspice: Abre el manual de ngspice.\n"\
	"ngspice-py: Inicia el script de python para la simulación con ngspicei.\n"\
	"circuito-e: \n\t Puede editar con VIM el circuito generado.\n"\
	"cicuito-g: \n\t Genera el circuito spice del esquema.\n"\
	"circuito-r: \n\t Remueve el archivo del circuito generado.\n"\
	"circuito-v: \n\t Ve con less el circuito generado.\n"\
	"simular: Simula solo teniendo el archivo de circuito.\n"\
	"convert-eps: \n\t Convierte el postscript generado \n"\
	"por ngspice en un archivo pdf y archivo eps encapsulado para LaTeX.\n"\
	"esquema: \n\t Abre y edita el esquema con gschem de gEDA.\n"\
	"help: \n\t Muestra esta ayuda.\n"\
	"option-g: \n\t Genera el archivo de configuración para imprimir"\
	"\n\tlos resultados de ngspice.\n"\
	"option-r: \n\tRemueve el archivo de configuración.\n"\
	"view-ps: \n\tMuestra el postscript generado por la simulación"\
	"hecha con ngspice.\n"\
	"ps-rename: \n\tDespués de traer el archivo generado por"\
	"\n\tngspice lo renombra como archivo.ps, para su fácil"\
	"\n\t vista.\n"\
	"##########################################################\n"	

