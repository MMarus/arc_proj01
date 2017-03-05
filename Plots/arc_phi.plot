#
# ARC 2016, VUT FIT
# Script generating Strong scaling on Xeon Phi plot on Salomon
# Author: Vojtech Nikl (inikl@fit.vutbr.cz)
# 
# Input:  benchmark_phi.csv 
# Output: arc_phi.svg
#

reset

input = '../Scripts/benchmark_phi.csv'

set term svg enhanced font 'Verdana,11'
set output 'arc_phi.svg'
set border linewidth 1

# define axis
# remove border on top and right and set color to gray
set style line 11 lc rgb '#808080' lt 1
set border 3 back ls 11
set tics nomirror
# define grid
set style line 12 lc rgb '#808080' lt 0 lw 0.25
set grid back ls 12

set datafile separator ";"

set xlabel 'Number of threads'
set ylabel 'Iteration time [ms]'
set key outside right center

set logscale x 2
set logscale y 2

set format y "%g" 
set xtics (60, 120, 240) out
set ytics out

#set autoscale fix
set title "Strong scaling on Salomon (Xeon Phi)"

set key invert
set key reverse
set key Left

set size square 1,1

flabel(y)=sprintf("%.2e", y*1000)

plot input\
   every   ::1::3 using 3:($11*1000) with linespoints title '256^2 I/O off'  lc rgb "#006400" pt 13 ps 0.75 dt 1,\
'' every   ::1::3 using 3:($11*1150):(flabel($11)) with labels notitle,\
'' every   ::4::6 using 3:($11*1000) with linespoints title '512^2 I/O off' lc rgb "#FF8C00" pt 5 ps 0.75 dt 1,\
'' every   ::4::6 using 3:($11*1150):(flabel($11)) with labels notitle,\
'' every   ::7::9 using 3:($11*1000) with linespoints title '1024^2 I/O off' lc rgb "red" pt 11 ps 0.75 dt 1, \
'' every   ::7::9 using 3:($11*1150):(flabel($11)) with labels notitle,\
'' every ::10::12 using 3:($11*1000) with linespoints title '2048^2 I/O off' lc rgb "#00BFFF" pt 15 ps 0.75 dt 1,\
'' every ::10::12 using 3:($11*1150):(flabel($11)) with labels notitle,\
