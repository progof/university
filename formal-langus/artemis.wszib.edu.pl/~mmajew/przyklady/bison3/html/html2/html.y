%{
#include <stdio.h>
int yylex();
int yyerror(const char*);
%}

%define parse.error verbose
%token HTML_O HTML_Z DOCTYPE BODY_O BODY_Z

%%
kod : DOCTYPE HTML_O zawartosc_html HTML_Z         { printf("\nSukces!!!\n"); }
    ;
zawartosc_html : BODY_O BODY_Z
    ;
%%
int main() {
   yyparse();
}

int yyerror(const char* msg) {
   printf("Blad skladniowy: %s\n", msg);
}
