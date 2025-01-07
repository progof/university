set terminal png size 800,600
set output "diagrams/ode_ex2_plot.png"
set title "Solving the equation van der Pola"
set xlabel "Time (t)"
set ylabel "Values y"
set grid
plot "diagrams/data-ex2.txt" using 1:2 with lines title "y_0 (position)", \
     "diagrams/data-ex2.txt" using 1:3 with lines title "y_1 (speed)"
