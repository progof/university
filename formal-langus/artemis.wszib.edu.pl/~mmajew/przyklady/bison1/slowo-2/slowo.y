/* slowo.y - przyklad ilustrujacy przedefiniowanie typu tokenu z int na char * */

%{
#include <stdio.h>
int yylex(void);
int yyerror(char *);

#define YYSTYPE char *
%}

%token T_ID

%%

input : input line '\n'
      | input '\n'           { YYACCEPT; }
      | // pusta produkcja 
      ;

line  : line T_ID         { printf("znaleziono: %s\n", $2); }
      | T_ID              { printf("znaleziono: %s\n", $1); }
      ;

%%
int main(){
  yyparse();
}

int yyerror(char *s) {
   printf("blad: %s\n", s);
}
