CC = gcc
LEX = flex
CFLAGS = -Wall

TARGET = scannerForAirport
SRC_FILE = Airports.csv

$(TARGET): lex.yy.c
	$(CC) $(CFLAGS) -o $(TARGET) lex.yy.c -ll

lex.yy.c: Airports.l
	$(LEX) -o lex.yy.c Airports.l

run: $(TARGET)
	./$(TARGET) < $(SRC_FILE)

clean:
	rm -f $(TARGET) lex.yy.c

.PHONY: run clean

