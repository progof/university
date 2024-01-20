/* stala.y - przyklad ilustrujacy przekazanie do parsera nazwy identyfikatora i wartosci stalej */

%{
#include <stdio.h>
int yylex(void);
int yyerror(char *);
%}

%union {
  char * napis;
  int liczba;
 }
%token <napis> T_ID
%token <liczba> T_STALA

%%

input   : input element
        | // pusta produkcja
        ;

element  :  T_ID     {  printf("Identyfikator: %s\n", $1); }
         |  T_STALA  {  printf("Stala: %d\n", $1); }
         ;

%%

int main(){
  yyparse();
}

int yyerror(char *s) {
   printf("blad: %s\n", s);
}
