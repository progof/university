# Zmienna do przechowywania nazw plików
CC = gcc
CFLAGS = -Wall -O2  # Flagi kompilatora
TARGET = signal_generator  # Nazwa pliku wykonywalnego
DATAPATH = signal_with_noise.dat
GP_SCRIPT = plot_signal.gp
OUTPUT_PLOT = signal_with_noise.png

# Domyślny cel - kompilacja i uruchomienie programu
all: $(TARGET) run

# Kompilacja programu
$(TARGET): main.c
	$(CC) $(CFLAGS) main.c -o $(TARGET)

# Uruchomienie programu, który generuje dane
run: $(TARGET)
	./$(TARGET)

# Generowanie wykresu za pomocą Gnuplota
plot: run
	gnuplot $(GP_SCRIPT)

# Czyszczenie plików wynikowych
clean:
	rm -f $(TARGET) $(DATAPATH) $(OUTPUT_PLOT)

.PHONY: all run plot clean
