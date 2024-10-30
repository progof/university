set terminal png enhanced
set output 'f2_approximation.png'

set title "Approximation of f2: y = 1 / (12 * x^2 + 1)"
set xlabel "x"
set ylabel "y"
set grid

plot "../data/f2_n3.dat" using 1:2 title "f2(x) (original)" with lines lw 2, \
     "../data/f2_n3.dat" using 1:3 title "Chebyshev Approx (n=3)" with lines lw 2, \
     "../data/f2_n10.dat" using 1:3 title "Chebyshev Approx (n=10)" with lines lw 2, \
     "../data/f2_n40.dat" using 1:3 title "Chebyshev Approx (n=40)" with lines lw 2
