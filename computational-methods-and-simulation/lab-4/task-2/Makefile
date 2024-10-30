CC=gcc
GSL_HOME=/usr/local/include/gsl

#CFLAGS=-I$(GSL_HOME)/include
#LDFLAGS=-L$(GSL_HOME)/lib -lgsl -lgslcblas -lm 
LDFLAGS=-lgsl -lgslcblas -lm 

all: approximation 

approximation: approximation.o
	$(CC) $(LDFLAGS) -o $@ $^

clean:
	rm -f *.o