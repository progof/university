# Ustawienia terminala i pliku wyjściowego
set terminal png enhanced size 800,600
set output 'signal_plot.png'

# Ustawienia wykresu
set title "Signal"
set xlabel "Index"
set ylabel "Value"
set grid

# Rysowanie wykresu
plot "signal_data.txt" using 1:2 with lines title "Signal" lw 2

# Zakończenie
set output
