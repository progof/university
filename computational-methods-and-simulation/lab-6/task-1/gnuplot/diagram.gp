# Wybór terminala wyjściowego
set terminal png
set output 'wykres1.png'

# Ustawienia tytułu i etykiet osi
set title "Wykres funkcji f(x) = x^2 - 5"
set xlabel "x"
set ylabel "f(x)"

# Włączenie siatki na wykresie
set grid

# Ustawienia zakresu osi x i y
set xrange [-1:3]
set yrange [-6:6]

# Rysowanie wykresu funkcji f(x) = x^2 - 5
plot x**2 - 5 with lines lw 2 title "f(x) = x^2 - 5"
