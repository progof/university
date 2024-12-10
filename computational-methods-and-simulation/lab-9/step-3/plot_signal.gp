# Skrypt Gnuplota do wykresu sygnału cosinus z szumem

set title "Cosine signal with noise"
set xlabel "Indeks"
set ylabel "Amplituda"
set grid

# Zapis do pliku PNG
set terminal png enhanced size 800,600
set output 'signal_with_noise.png'

# Wczytanie danych z pliku
plot "signal_with_noise.dat" using 1:2 with lines title "Signal with noise"
