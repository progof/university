# Nazwa kompilowanego programu
TARGET = signal_generator

# Kompilator i opcje kompilacji
CC = gcc
CFLAGS = -Wall -O2

# Biblioteki do połączenia (GSL i matematyczne)
LIBS = -lgsl -lgslcblas -lm

# Plik źródłowy
SRC = main.c

# Plik obiektowy
OBJ = main.o

# Cele (targets)
all: $(TARGET)

# Kompilacja programu
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LIBS)

# Kompilacja pliku źródłowego do obiektu
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $(SRC)

# Czyszczenie plików po kompilacjis
clean:
	rm -f $(TARGET) $(OBJ)
	rm -f *.dat
	rm -f *.txt

# Cel do uruchomienia programu
run: $(TARGET)
	./$(TARGET)

# Cel do uruchomienia Gnuplota
plot:
	gnuplot plot_fft.gp
