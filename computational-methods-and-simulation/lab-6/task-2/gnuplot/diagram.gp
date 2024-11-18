# Ustawienia terminala i pliku wyjściowego
set terminal png size 800,600
set output 'wykres1.png'

# Ustawienia wykresu
set title "Wykres funkcji f(x) = x^2 - 2x + 1"
set xlabel "x"
set ylabel "f(x)"

# Rysowanie wykresu z pliku danych lub bezpośrednio funkcji
plot "quadratic.dat" using 1:2 with lines title "f(x) = x^2 - 2x + 1"
# Jeśli chcesz rysować funkcję bez pliku, użyj poniższego:
# plot x**2 - 2*x + 1 title "f(x) = x^2 - 2x + 1"
