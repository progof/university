parser: y.tab.c lex.yy.c
    gcc -o parser y.tab.c lex.yy.c -ll

y.tab.c: parser.y
    bison -y -d parser.y

lex.yy.c: lexer.l
    flex lexer.l

clean:
    rm -f parser lex.yy.c y.tab.c y.tab.h
