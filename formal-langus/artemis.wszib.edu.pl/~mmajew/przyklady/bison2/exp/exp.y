/* exp.y - wygenerowany parser bedzie wykonywal odejmowanie */

%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token NUM

%%
input: /* empty */
     | input line
     ;

line: '\n'
    | exp '\n'    { printf("%d\n", $1); }
    ;

exp: NUM
    | exp '-' exp       { $$ = $1 - $3; }
    | '(' exp ')'       { $$ = $2; }
    ;

/* Jezeli na wejsciu parsera podamy ciag 4-3-1, to otrzymamy 2. Dlaczego?
   Co zrobic, aby parser wypisywal poprawny wynik, tj. 0? */

/* Nawet jesli podczas analizy gramatyki bison wykryje konflikt, to mimo to wygeneruje parser:
   - konflikt shift/reduce jest rozstrzygany na korzysc shift
   - konflikt reduce/reduce jest rozstrzygany na korzysc reguly wystepujacej wczesniej w specyfikacji */


%%

void yyerror(char *s) {

   fprintf(stderr, "blad: %s\n", s);
}

int main() {

  yyparse();
}