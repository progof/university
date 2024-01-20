%{
#include "parser.tab.h"
%}

%option noyywrap

%%

[0-9]+ { return INTEGER; }

[a-zA-Z][a-zA-Z0-9]* { return IDENTIFIER; }

"="              { return ASSIGNMENT_OP; }
"+"              { return ADD_OP; }
"-"              { return SUB_OP; }
"*"              { return MUL_OP; }
"/"              { return DIV_OP; }
"++"             { return INC_OP; }
"--"             { return DEC_OP; }
";"              { return SEMICOLON; }
"{"              { return LBRACE; }
"}"              { return RBRACE; }
[ \t\n]          { /* ignoruj białe znaki */ }
.                { printf("Nieznany znak: %s\n", yytext); }

%%

