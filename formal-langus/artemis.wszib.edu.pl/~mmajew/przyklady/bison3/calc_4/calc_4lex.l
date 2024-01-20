/* calc_4lex.l - skaner wspolpracujacy z parserem calc_4.y */

%{
    #include "calc_4.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[a-z]       {
                yylval = *yytext - 'a';
                return VARIABLE;
                }

[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

[-+()=/*\n]     { return *yytext; }

[ \t]   ;       /* pomin */

.               yyerror("Nieznany znak");

%%

int yywrap(void) {
    return 1;
}
