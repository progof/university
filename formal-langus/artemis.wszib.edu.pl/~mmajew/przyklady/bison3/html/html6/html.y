%{
#include <stdio.h>
int yylex();
int yyerror(const char*);
extern int yylineno;
int licznik_bledow=0;
%}

%define parse.error verbose
%token HTML_O HTML_Z DOCTYPE BODY_O BODY_Z P_O P_Z B_O B_Z BR TEXT

%%
kod: DOCTYPE HTML_O zawartosc_html HTML_Z	{ if(licznik_bledow==0) printf("\nSukces!!!\n"); }
    ;
zawartosc_html : BODY_O zawartosc_body BODY_Z
    ;
zawartosc_body : P_O zawartosc_paragrafu P_Z
		| P_O error P_Z			{ yyerror("Niesparowany znacznik <b>"); }
    ;
zawartosc_paragrafu : zawartosc_paragrafu B_O zawartosc B_Z
		    | zawartosc_paragrafu BR
		    | zawartosc_paragrafu TEXT
		    | error B_Z			{ yyerror("Niesparowany znacznik </b>"); }
    ;
zawartosc : zawartosc TEXT
	  | TEXT    
	  ;
%%
int main() {
   yyparse();
}

int yyerror(const char* msg) {
   printf("Blad skladniowy w linii %d: %s\n", yylineno, msg);
   licznik_bledow++;
}
