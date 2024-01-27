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
"<"                     { return GREATER_OPEN; }
">"                     { return GREATER_CLOSE; }
"+"                     { return ADD_OP; }
"-"                     { return SUB_OP; }
"*"                     { return MUL_OP; }
"/"                     { return DIV_OP; }
"="                     { return ASSIGNMENT_OP; }
"System.out.println"    { return PRINT; }
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[0-9]+                  { return NUMBER; }
\"([^\"\n]|\\.)*\"      { return STRING; }
"("                     { return PAREN_OPEN; }
")"                     { return PAREN_CLOSE; }
"{"                     { return LBRACE; }
"}"                     { return RBRACE; }
";"                     { return SEMICOLON; }
[ \t\n]                 ; /* Ignore whitespace */

.                       { printf("Invalid character: %s\n", yytext); exit(1); }

%%