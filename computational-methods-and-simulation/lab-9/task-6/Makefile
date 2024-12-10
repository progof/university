# Definicja zmiennych
CC = gcc
CFLAGS = -Wall -g  # Opcje kompilatora
LDFLAGS = -lgsl -lgslcblas -lm  # Biblioteki do linkowania

# Nazwa pliku wykonywalnego
TARGET = fft_program

# Plik źródłowy
SRC = main.c  # Zmieniono na 'main.c'

# Plik obiektowy
OBJ = main.o  # Zmieniono na 'main.o'

# Domyślna reguła
all: $(TARGET)

# Kompilacja pliku źródłowego na plik obiektowy
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $(SRC)

# Łączenie pliku obiektowego z bibliotekami do pliku wykonywalnego
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Usuwanie plików obiektowych i wykonywalnych
clean:
	rm -f $(OBJ) $(TARGET)

# Reguła do uruchomienia programu
run: $(TARGET)
	./$(TARGET)

plot:
	gnuplot ifft_plot.gp
