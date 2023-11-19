CC = gcc
LEX = flex
CFLAGS = -Wall

TARGET = scannerForJava
SRC_FILE = test_skanera.java

$(TARGET): lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o $(TARGET) -lfl

lex.yy.c: scannerForJava.l
	$(LEX) scannerForJava.l

run: $(TARGET)
	./$(TARGET) < $(SRC_FILE)

clean:
	rm -f $(TARGET) lex.yy.c

.PHONY: run clean


