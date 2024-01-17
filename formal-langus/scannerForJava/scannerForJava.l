%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%
"switch"    { printf("Keyword: switch\n"); }
"class"     { printf("Keyword: class\n"); }
"import"    { printf("Keyword: import\n"); }

"int"       { printf("Type: int\n"); }
"float"     { printf("Type: float\n"); }
"double"    { printf("Type: double\n"); }
"char"      { printf("Type: char\n"); }

"int|float|double|char"  { printf("Type: %s\n", yytext); }

[-+*/]      { printf("Arithmetic Operator: %s\n", yytext); }

"="             { printf("Assignment Operator: =\n"); }
"\/\/".         { printf("Single-line Comment\n"); }
"\/\*".*"\*\/"  { printf("Multi-line Comment\n"); }

[a-zA-Z_][a-zA-Z0-9_]*          { printf("Identifier: %s\n", yytext); }

[0-9]+                          { printf("Integer: %s\n", yytext); }
[0-9]+[fF]?(\.[0-9]{1,7})?      { printf("Float: %s\n", yytext); }
[0-9]+(\.[0-9]{1,15})?[dD]?     { printf("Double: %s\n", yytext); }
\"(\\.|[^\"])*\"                { printf("String: %s\n", yytext); }

\"(\\.|[^\"])*\"        { printf("String: %s\n", yytext); }

[ \t\n]                 ; 
.                       { printf("Unknown token: %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}
