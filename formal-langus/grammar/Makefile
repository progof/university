PROG = parser

${PROG}: ${PROG}.tab.c lex.yy.c
	gcc -o ${PROG} ${PROG}.tab.c lex.yy.c -ll

${PROG}.tab.c: ${PROG}.y
	bison -d ${PROG}.y

lex.yy.c: lexer.l
	flex lexer.l

run: ${PROG}
	./${PROG} <test_blok_instrukcji

clean:
	rm -f parser lex.yy.c parser.tab.c parser.tab.h
