# Nazwa pliku wykonywalnego
EXEC = life_mpi

# Kompilator i flagi
CC = mpicc
CFLAGS = -Wall -Wextra -O2

# Pliki źródłowe
SRC = $(EXEC).c

# Domyślny cel
all: $(EXEC)

# Kompilacja programu
$(EXEC): $(SRC)
	$(CC) $(CFLAGS) -o $(EXEC) $(SRC)

# Uruchamianie programu
run: $(EXEC)
	mpirun -np 4 ./$(EXEC) 10 0.7 100

# Czyszczenie plików
clean:
	rm -f $(EXEC)

# Cel pomocniczy, by upewnić się, że `make clean` działa zawsze
.PHONY: all run clean
