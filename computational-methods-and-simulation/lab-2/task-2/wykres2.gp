# Ustawienia wyjścia
set terminal png font 'arial,10'
set output 'wykres.png'

# Ustawienia wykresu
set title 'Wykres 2D z danych'
set xlabel 'X'
set ylabel 'Y'
set zlabel 'Z'
set view 60, 30  # Kąt widzenia

# Ustawienia siatki
set grid

# Ustawienia zakresu osi
set xrange [0:2.5]
set yrange [0:5.75]
set zrange [-0.01:0.1]

# Wykres powierzchni z pliku
splot 'dane2.dat' using 1:2:3 with lines palette title 'Zależność Z od X i Y'

# Zamknięcie wyjścia
set output
