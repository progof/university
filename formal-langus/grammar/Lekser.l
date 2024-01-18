%{
#include "y.tab.h"
%}

%%
[ \t\n]          /* Ignore whitespaces and tabs */
[0-9]+           { yylval.num = atoi(yytext); return INTEGER; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return IDENTIFIER; }
"="              { return ASSIGNMENT_OP; }
"+"              { return ADD_OP; }
"-"              { return SUB_OP; }
"*"              { return MUL_OP; }
"/"              { return DIV_OP; }
"++"             { return INC_OP; }
"--"             { return DEC_OP; }
";"              { return SEMICOLON; }
"{"              { return '{'; }
"}"              { return '}'; }
.                ;

%%

int yywrap() {
    return 1;
}
