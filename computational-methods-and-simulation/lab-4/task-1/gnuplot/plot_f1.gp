set terminal png enhanced
set output 'f1_approximation.png'

set title "Approximation of f1: y = exp(x) * cos(0.5 * x^2)"
set xlabel "x"
set ylabel "y"
set grid

plot "../data/f1_n3.dat" using 1:2 title "f1(x) (original)" with lines lw 2, \
     "../data/f1_n3.dat" using 1:3 title "Chebyshev Approx (n=3)" with lines lw 2, \
     "../data/f1_n10.dat" using 1:3 title "Chebyshev Approx (n=10)" with lines lw 2, \
     "../data/f1_n40.dat" using 1:3 title "Chebyshev Approx (n=40)" with lines lw 2

