PROG = stala

all: ${PROG} run

${PROG}.tab.c: ${PROG}.y
	bison -d ${PROG}.y

lex.yy.c: ${PROG}lex.l
	flex ${PROG}lex.l
    
${PROG}: ${PROG}.tab.c lex.yy.c
	gcc -o ${PROG} ${PROG}.tab.c lex.yy.c -lfl
    
run: ${PROG}
	./${PROG} <test_${PROG}
