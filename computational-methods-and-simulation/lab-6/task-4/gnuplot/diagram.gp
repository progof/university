# Run Gnuplot and load the following script

set terminal png size 800,600 font "Courier,12"
set output 'newton_errors.png'
set title "Error of Newton's Method"
set xlabel "Iteration"
set ylabel "Error"
plot "../newton_errors.txt" using 1:2 with lines title "Newton's Error"

set output 'bisection_errors.png'
set title "Error of Bisection Method"
set xlabel "Iteration"
set ylabel "Error"
plot "../bisection_errors.txt" using 1:2 with lines title "Bisection's Error"
