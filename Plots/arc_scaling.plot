#
# ARC 2016, VUT FIT
# Script generating Strong scaling plot on Salomon
# Author: Vojtech Nikl (inikl@fit.vutbr.cz)
# 
# Input:  benchmark.csv 
# Output: arc_scaling.svg
#


reset

input = '../Scripts/benchmark.csv'

set term svg enhanced font 'Verdana,11'
set output 'arc_scaling.svg'
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
set xtics (1,2,4,6,8,12,16,20,24) out
set ytics out

#set autoscale fix
set title "Strong scaling on Salomon"

set key invert
set key reverse
set key Left

set size square 1,1


plot input\
   every   ::1::9 using 3:($11*1000) with linespoints title '64^2 non-overlapped' lc rgb "#9400D3" pt 8 ps 0.75 dt 3,\
'' every ::10::17 using 3:($11*1000) with linespoints title '64^2 overlapped' lc rgb "#9400D3" pt 9 ps 0.75 dt 1,\
'' every ::18::26 using 3:($11*1000) with linespoints title '128^2 non-overlapped' lc rgb "blue" pt 6 ps 0.75 dt 3, \
'' every ::27::34 using 3:($11*1000) with linespoints title '128^2 overlapped' lc rgb "blue" pt 7 ps 0.75 dt 1, \
'' every ::35::43 using 3:($11*1000) with linespoints title '256^2 non-overlapped' lc rgb "#006400" pt 12 ps 0.75 dt 3, \
'' every ::44::51 using 3:($11*1000) with linespoints title '256^2 overlapped'  lc rgb "#006400" pt 13 ps 0.75 dt 1, \
'' every ::52::60 using 3:($11*1000) with linespoints title '512^2 non-overlapped' lc rgb "#FF8C00" pt 4 ps 0.75 dt 3, \
'' every ::61::68 using 3:($11*1000) with linespoints title '512^2 overlapped' lc rgb "#FF8C00" pt 5 ps 0.75 dt 1, \
'' every ::69::77 using 3:($11*1000) with linespoints title '1024^2 non-overlapped' lc rgb "red" pt 10 ps 0.75 dt 3, \
'' every ::78::85 using 3:($11*1000) with linespoints title '1024^2 overlapped' lc rgb "red" pt 11 ps 0.75 dt 1, \
