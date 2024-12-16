set terminal png enhanced size 800,600
set output 'signal_plot222.png'

# Ustawienie tytułu wykresu i etykiet osi
set title "Wykres funkcji f(x) = cos(x) + 1"
set xlabel "x"
set ylabel "f(x)"

# Ustawienie zakresu osi x
set xrange [0:6]

# Ustawienie zakresu osi y
set yrange [0:2]

# Rysowanie wykresu
plot cos(x) + 1 title "f(x) = cos(x) + 1" with lines
