CC = gcc
LEX = flex

lotniska: Airports.l
	$(LEX) -o airports.c Airports.l
	$(CC) -o airports airports.c -lfl

clean:
	rm -f airports airports.c
