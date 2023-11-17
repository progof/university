PROG = jaguar1

all : ${PROG}

lex.yy.c: ${PROG}.l
	flex ${PROG}.l

${PROG}: lex.yy.c
	gcc -o ${PROG} lex.yy.c -ll
	./${PROG}

clean:
	rm lex.yy.c ${PROG}