# Nazwa pliku wykonywalnego
EXEC = rectangle_integration

# Flagi kompilacji
CFLAGS = -Wall -lm

# Pliki źródłowe
SRC = rectangle_integration.c

# Reguła główna
all: $(EXEC)

# Kompilacja programu
$(EXEC): $(SRC)
	$(CC) $(CFLAGS) -o $(EXEC) $(SRC)

# Czyszczenie plików wykonywalnych
clean:
	rm -f $(EXEC)

run: $(EXEC)
	./$(EXEC)
