%{
#include <stdio.h>
int yylex();
int yyerror(const char*);
%}


%token HTML_O HTML_Z

%%
kod:  HTML_O  HTML_Z         { printf("\nSukces!!!\n"); }
    ;
%%
int main() {
   yyparse();
}

int yyerror(const char* msg) {
   printf("Blad skladniowy: %s\n", msg);
}
