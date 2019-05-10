script = gnuplot.gnu
csv1 =
csv2 =
out = $(script)
#out =

create_eps: $(script)
	gnuplot -c $(script) $(out).eps $(csv1) $(csv2)

all: create_eps
	evince $(out).eps

edit:
	vim -o Makefile $(script)

clean:
	rm $(out).eps

help:
	@echo "make all"
	@echo "make script=file.gnu"
	@echo "make csv1=file.csv"
