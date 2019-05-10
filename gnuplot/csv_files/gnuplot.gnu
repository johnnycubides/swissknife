#!/usr/bin/gnuplot
# gnuplot -c plot.gnu ARG1 ARG2 ARG3"
print "gnuplot -c plot.gnu out_eps channel1 channel2"
print "gnuplot -c ". ARG0." ".ARG1." ".ARG2." ".ARG3

file_out=ARG1

set terminal eps
set output file_out
set datafile separator ","
set grid
set xlabel "" #"labelx"
set ylabel "" #"labely"
set title "" #"titleGraph"
m=1
n=2
plot ARG2 using m:n with line title "" linecolor rgb "red"#with lp # m <- column, n <- this column, (1*$n):($m/1)
#plot ARG2 using m:n with line title "" linecolor rgb "red", ARG3 using m:n with line title "" linecolor rgb "blue" #with lp # $m <- column, $n <- this column, (1*$n):($m/1)

