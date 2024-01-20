/* example.y - prosty parser */

%{
#include <stdio.h>
int yylex();
int yyerror(char *);
%}

%token T_CHAR

%%

input :  input T_CHAR           { printf("rozpoznano - %c\n", $2); };
      |  /*  pusta produkcja */
      ;

%%
#include "lex.yy.c"

int main() {

  yyparse();
}

int yyerror(char *s) {

    printf("blad: %s\n", s);
}
