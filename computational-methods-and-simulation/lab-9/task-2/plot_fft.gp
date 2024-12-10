set terminal png enhanced size 800,600
set output 'spectrum_plot_2.png'

set title "Spectrum of frequencies"
set xlabel "Frequency"
set ylabel "Amplituda"
set grid
set style fill solid 0.5
set style data lines
set key left top

plot "output_signal.txt" using 1:2 with boxes title "Spectrum"



