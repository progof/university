CC = gcc
CFLAGS = -Wall -O2 -lm
LIBS = -lgsl -lgslcblas

SRC = main.c
OBJ = main.o
EXEC = signal_processor

# Domyślny cel
all: $(EXEC)

# Kompilacja programu
$(EXEC): $(OBJ)
	$(CC) $(OBJ) -o $(EXEC) $(LIBS)

# Kompilacja pliku .c do .o
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $(SRC)

# Czyszczenie plików obiektowych i wynikowego
clean:
	rm -f $(OBJ) $(EXEC)
	rm -f *.dat


# Uruchomienie programu
run: $(EXEC)
	./$(EXEC)

