PROG = html

all: ${PROG} run

${PROG}.tab.c: ${PROG}.y
	bison -Wcounterexamples -d ${PROG}.y

lex.yy.c: ${PROG}lex.l
	flex ${PROG}lex.l
    
${PROG}: ${PROG}.tab.c lex.yy.c
	gcc -o ${PROG} ${PROG}.tab.c lex.yy.c -lfl 
    
run: ${PROG}
	echo
	cat test_${PROG}_2
	echo
	./${PROG} <test_${PROG}_2
