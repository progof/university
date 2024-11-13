# Nazwa pliku wykonywalnego
EXEC = calculate_integrals_gsl

# Flagi kompilacji
CFLAGS = -Wall
LDFLAGS = -lgsl -lgslcblas -lm

# Pliki źródłowe
SRC = calculate_integrals_gsl.c

# Reguła główna
all: $(EXEC)

# Kompilacja programu
$(EXEC): $(SRC)
	$(CC) $(CFLAGS) -o $(EXEC) $(SRC) $(LDFLAGS)

# Czyszczenie plików wykonywalnych
clean:
	rm -f $(EXEC)

run: $(EXEC)
	./$(EXEC)
