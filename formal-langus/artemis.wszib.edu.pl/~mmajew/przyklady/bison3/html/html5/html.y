%{
#include <stdio.h>
int yylex();
int yyerror(const char*);
%}

%define parse.error verbose
%token HTML_O HTML_Z DOCTYPE BODY_O BODY_Z P_O P_Z B_O B_Z BR TEXT

%%
kod: DOCTYPE HTML_O zawartosc_html HTML_Z         { printf("\nSukces!!!\n"); }
    ;
zawartosc_html : BODY_O zawartosc_body BODY_Z
    ;
zawartosc_body : P_O zawartosc_paragrafu P_Z
    ;
zawartosc_paragrafu : zawartosc_paragrafu B_O zawartosc B_Z
		    | zawartosc_paragrafu BR
		    | zawartosc_paragrafu zawartosc
		    | TEXT
    ;
zawartosc : zawartosc TEXT
	  | TEXT    
	  ;
%%
int main() {
   yyparse();
}

int yyerror(const char* msg) {
   printf("Blad skladniowy: %s\n", msg);
}
    
    