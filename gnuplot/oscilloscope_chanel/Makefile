script = gnuplot.gnu
channel1 =
channel2 =
out = $(script)
#out =

create_eps: $(script)
	gnuplot -c $(script) $(out).eps $(channel1) $(channel2)

all: create_eps
	evince $(out).eps

edit:
	vim -o Makefile $(script)

clear:
	rm $(out).eps
