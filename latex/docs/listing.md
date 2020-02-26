# Agregando código

[Fuentes](https://es.wikibooks.org/wiki/Manual_de_LaTeX/Listados_de_c%C3%B3digo/Listados_con_listings)

## Lenguajes soportados

El paquete listings es capaz de resaltar los siguientes lenguajes:

ABAP[2,4], ACSL, Ada[4], Algol[4], Ant, Assembler[2,4], Awk[4], bash, Basic[2,4], C#[5], C++[4], C[4], Caml[4], Clean, Cobol[4], Comal, csh, Delphi, Eiffel, Elan, erlang, Euphoria, Fortran4, GCL, Gnuplot, Haskell, HTML, IDL[4], inform, Java[4], JVMIS, ksh, Lisp[4], Logo, Lua[2], make[4], Mathematica[1,4], Matlab, Mercury, MetaPost, Miranda, Mizar, ML, Modelica[3], Modula-2, MuPAD, NASTRAN, Oberon-2, Objective C[5] , OCL[4], Octave, Oz, Pascal[4], Perl, PHP, PL/I, Plasm, POV, Prolog, Promela, Python, R, Reduce, Rexx, RSL, Ruby, S4, SAS, Scilab, sh, SHELXL, Simula4, SQL, tcl[4], TeX[4], VBScript, Verilog, VHDL[4], VRML[4], XML, XSLT.

Para algunos de ellos, se permiten diferentes dialectos. Para más información, utiliza la documentación que viene con el paquete, debería estar en tu distribución, bajo el nombre listings-*.dvi. 

### Notas

1. Soporta Mathematica solamente si se trata de un fichero en texto plano. No se pueden incluir ficheros *.NB., sin embargo, Mathematica puede exportar ficheros fuente formateados para su uso en LaTeX.
2. En estos lenguajes es obligatorio especificar el dialecto del lenguaje (por ejemplo: language={[x86masm]Assembler}).
3. Modelica se soporta mediante el paquete dtsyntax disponible aquí.
4. Para estos lenguajes hay múltiples dialectos soportados: C, por ejemplo, puede ser ANSI, Handel, Objective y Sharp. Ver p. 12 del manual de listings para una introducción a esto.
5. Definido como un dialecto de otro lenguaje.

## Ejemplos

```tex
\begin{lstlisting}[language={[5.1]Lua}, caption=Script init.lua, label=code_init, basicstyle=\ttfamily\footnotesize]
```

