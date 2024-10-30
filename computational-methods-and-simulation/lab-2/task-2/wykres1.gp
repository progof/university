# Skrypt Gnuplot do rysowania wykresu z dane1.dat

set terminal png
set output 'wykres1.png'

set title "Symulacja stygniecia gwiazd neutronowych"
set xlabel "Czas (logarytmiczny)"
set ylabel "Temperatura"

set logscale x

plot 'dane1.dat' using 1:2 with lines title "Temperatura"