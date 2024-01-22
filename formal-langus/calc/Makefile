PROG = calc
OS := $(shell uname)

ifeq ($(OS), Linux)
    LIBS = -lfl
else
    LIBS = -ll
endif

${PROG}: ${PROG}.tab.c ${PROG}lex.yy.c
	gcc -o ${PROG} ${PROG}.tab.c ${PROG}lex.yy.c ${LIBS}

${PROG}.tab.c: ${PROG}.y
	bison -d ${PROG}.y

${PROG}lex.yy.c: ${PROG}lex.l
	flex -o ${PROG}lex.yy.c ${PROG}lex.l 

run: ${PROG}
	./${PROG} < test_${PROG}

clean:
	rm -f ${PROG} ${PROG}lex.yy.c ${PROG}.tab.c ${PROG}.tab.h