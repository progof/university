/* stalalex.l - skaner wspolpracujacy z parserem stala.y */
%{
#include "stala.tab.h"
%}

%%
[a-zA-Z]+   { yylval.napis = yytext;
              return T_ID;
            }
[0-9]+      { yylval.liczba = atoi(yytext);
              return T_STALA;
            }
.|\n        ; // pomin
