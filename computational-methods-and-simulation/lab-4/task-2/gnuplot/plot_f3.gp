# Ustawienia wyjściowego katalogu
set terminal png size 800,600 enhanced font 'Arial,10'
set output "chebyshev_f3.png"

# Parametry wykresu
set grid
set xlabel "x"
set ylabel "y"
set key left top
set title "Aproksymacja Czebyszewa dla funkcji y = cos(x) + A*sin(B*x)"

# Ustawienia wartości A i B
A = 0.05
B = 50

# Oryginalna funkcja f3
f3(x) = cos(x) + A * sin(B * x)

# Rysowanie wykresu funkcji oryginalnej i jej aproksymacji
plot f3(x) title "f3(x) - oryginalna", \
     "../data/f3_n3.dat" using 1:3 with lines title "Aproksymacja Czebyszewa (n = 3)", \
     "../data/f3_n10.dat" using 1:3 with lines title "Aproksymacja Czebyszewa (n = 10)", \
     "../data/f3_n40.dat" using 1:3 with lines title "Aproksymacja Czebyszewa (n = 40)"
