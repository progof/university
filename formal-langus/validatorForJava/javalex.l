%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "java.tab.h"
%}

%%

"if"                    { return IF; }
"else"                  { return ELSE; }
"=="                    { return EQ; }
"!="                    { return NEQ; }
"<="                    { return LEQ; }
">="                    { return GEQ; }
"<"                     { return '<'; }
">"                     { return '>'; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"="                     { return '='; }
"System.out.println"    { return PRINT; }
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[0-9]+                  { return NUMBER; }
\"([^\"\n]|\\.)*\"      { return STRING; }
\(                      { return '('; }
\)                      { return ')'; }
\{                      { return '{'; }
\}                      { return '}'; }
";"                     { return ';'; }
[ \t\n]                 ; /* Ignore whitespace */

.                       { printf("Invalid character: %s\n", yytext); exit(1); }

%%



