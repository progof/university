CC=gcc
GSL_HOME=/usr/local/include/gsl

#CFLAGS=-I$(GSL_HOME)/include
#LDFLAGS=-L$(GSL_HOME)/lib -lgsl -lgslcblas -lm 
LDFLAGS=-lgsl -lgslcblas -lm 

all: main 

main: main.o
	$(CC) $(LDFLAGS) -o $@ $^

run: main
	./main

clean:
	rm -f *.o