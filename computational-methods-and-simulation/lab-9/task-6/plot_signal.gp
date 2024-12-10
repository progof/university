set terminal png size 800,600
set output 'signal_plot.png'
set grid

set title "Time signal diagram"
set xlabel "Time"
set ylabel "Amplituda"
plot "signal_output.txt" with lines

