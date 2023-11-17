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
"String"    { printf("Type: String\n"); }

"+"         { printf("Operator: +\n"); }
"-"         { printf("Operator: -\n"); }
"*"         { printf("Operator: *\n"); }
"/"         { printf("Operator: /\n"); }

"="         { printf("Assignment Operator: =\n"); }

"//"        { printf("Single-line Comment\n"); }

[a-zA-Z_][a-zA-Z0-9_]*   { printf("Identifier: %s\n", yytext); }

[0-9]+                  { printf("Integer: %s\n", yytext); }
[0-9]+"."[0-9]+[fF]?    { printf("Float: %s\n", yytext); }
[0-9]+"."[0-9]+[dD]?    { printf("Double: %s\n", yytext); }

\"(\\.|[^\"])*\"        { printf("String: %s\n", yytext); }

[ \t\n]                 ; // Ignore whitespace and newline
.                       { printf("Unknown token: %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}
