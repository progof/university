%{
#include <stdio.h>
#include <math.h>
int yyerror(const char *);
int yylex(void);
%}

%union {
  float fval;
}

%token <fval> FLOAT
%type <fval> expression
%left '+' '-'
%left '*' '/' 
%right UMINUS '^'

%%

calculator:  calculator statement '\n'
          |  calculator '\n'
          |  /* pusta regula */
          ;

statement:  expression  { printf("Wynik dzialania: %f\n", $1) ; }
         ;

expression:  FLOAT                        { $$ = $1; }
          | expression '+' expression     { $$ = $1 + $3; }
          | expression '-' expression     { $$ = $1 - $3; }
          | expression '/' expression     {
                                            if($3 == 0) {
                                               yyerror("Nie mozna dzielic przez 0");
                                               $$ = 0;
                                            } else $$ = $1 / $3; 
                                          }
          | expression '*' expression     { $$ = $1 * $3; }
          | expression '^' expression     { $$ = pow($1, $3); }
          | '-' expression  %prec UMINUS  { $$ = -$2; }
          | '(' expression ')'            { $$ = $2; }
          ;

%%

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}

int main() { 
    yyparse();
}