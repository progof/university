CC=gcc
GSL_HOME=/usr/local/include/gsl
LDFLAGS=-lgsl -lgslcblas -lm 

all: fft_signal_transform 

fft_signal_transform: fft_signal_transform.o
	$(CC) $(LDFLAGS) -o $@ $^

run: fft_signal_transform
	./fft_signal_transform

clean:
	rm -f *.o
	rm -f *.txt

plot:
	gnuplot plot_fft.gp