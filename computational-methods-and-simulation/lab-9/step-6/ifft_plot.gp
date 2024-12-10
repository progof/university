# Skrypt do gnuplot dla danych z ifft_output.txt

# Ustawienia wykresu
set terminal png size 800,600
set output 'ifft_plot.png'

# Tytuł wykresu
set title 'Inverse Fourier Transform'
set xlabel 'Index'
set ylabel 'Amplituda'

# Kolory dla wykresów
set style line 1 lc rgb 'blue' lw 2  # Część rzeczywista (niebieska)
set style line 2 lc rgb 'red' lw 2   # Część urojona (czerwona)

# Wczytywanie danych i tworzenie wykresu
plot 'ifft_output.txt' using 1:2 with lines title 'Real Part' ls 1, \
     'ifft_output.txt' using 1:3 with lines title 'Delusional Part' ls 2
