CC = gcc
LEX = flex
CFLAGS = -Wall

TARGET = scannerForJava
SRC_FILE = test_skaner.java

$(TARGET): lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o $(TARGET) -ll

lex.yy.c: scannerForJava.l
	$(LEX) scannerForJava.l

run: $(TARGET)
	./$(TARGET) $(SRC_FILE)

clean:
	rm -f $(TARGET) lex.yy.c

.PHONY: run clean


