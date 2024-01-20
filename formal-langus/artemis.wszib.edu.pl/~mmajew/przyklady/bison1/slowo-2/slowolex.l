/* slowolex.l - skaner wspolpracujacy z parserem slowo.y */
%{
#define YYSTYPE char *
#include "slowo.tab.h"
%}

%%
[a-zA-Z]+    { yylval = yytext;
               return T_ID;
            }
\n            return '\n';
[ \t]       ;    // pomin
.           ;    // pomin
