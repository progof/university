set terminal png size 800,600
set output 'fft_plot.png'
set xlabel 'Frequency (Hz)'
set ylabel 'Amplituda'
set title 'Frequency spectrum - FFT'

# Wczytaj dane i stwórz wykres
plot 'output_fft.txt' using 1:2 with lines title 'FFT'
