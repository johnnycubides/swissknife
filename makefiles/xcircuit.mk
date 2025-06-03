# The id "f" represent the files.ps to convert in file.pdf
f=

h:help
convert:ps2pdf
edit:edit-xcircuit

help:
	@echo "Examples to use:"
	@echo "make ps2pdf f=file.ps"
	@echo "make edit-xcircuit f=file.ps"

# make ps2pdf f=file.ps
ps2pdf:
	ps2pdf -dEPSCrop $f

# make edit-circuit f=file.ps
edit-xcircuit:
	xcircuit $f

