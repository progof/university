CC=gcc
GSL_HOME=/usr/local/include/gsl
#CFLAGS=-I$(GSL_HOME)/include
#LDFLAGS=-L$(GSL_HOME)/lib -lgsl -lgslcblas -lm 
LDFLAGS=-lgsl -lgslcblas -lm 

all: ode-ex1 ode-ex2 ode-ex3

ode-ex1: ode-ex1.o
	$(CC) $(LDFLAGS) -o $@ $^

ode-ex2: ode-ex2.o
	$(CC) $(LDFLAGS) -o $@ $^

ode-ex3: ode-ex3.o
	$(CC) $(LDFLAGS) -o $@ $^

run: ode-ex1
	./ode-ex1

run2: ode-ex2
	./ode-ex2

run3: ode-ex3
	./ode-ex3


clean:
	rm -f *.o

plot1:
	gnuplot diagrams/plot_script1.gp

plot2:
	gnuplot diagrams/plot_script2.gp

plot3:
	gnuplot diagrams/plot_script3.gp