PROG = html

all: ${PROG} run

${PROG}.tab.c: ${PROG}.y
	bison -d ${PROG}.y

lex.yy.c: ${PROG}lex.l
	flex ${PROG}lex.l
    
${PROG}: ${PROG}.tab.c lex.yy.c
	gcc -o ${PROG} ${PROG}.tab.c lex.yy.c -ll 
    
run: ${PROG}
	cat test_${PROG}
	echo
	./${PROG} <test_${PROG}
