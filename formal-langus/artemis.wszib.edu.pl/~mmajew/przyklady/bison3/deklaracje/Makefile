PROG = deklaracje

all: ${PROG} run

${PROG}.tab.c: ${PROG}.y
	bison -d ${PROG}.y

lex.yy.c: ${PROG}lex.l
	flex ${PROG}lex.l
    
${PROG}: ${PROG}.tab.c lex.yy.c
	gcc -o ${PROG} ${PROG}.tab.c lex.yy.c -ll 
    
run: ${PROG}
	./${PROG} <test_${PROG}

clean:
	rm -f ${PROG} lex.yy.c ${PROG}.tab.c ${PROG}.tab.h
