%{
  #include "deklaracje.tab.h"
%}
%option yylineno

%%

"int"|"char"|"char *"          { printf("--%s-- ", yytext); return TYP; }
[a-zA-Z][a-zA-Z0-9_\-]*        { printf("--%s-- ", yytext); return ID; }
";"                            { printf("--%s-- ", yytext); return (*yytext); }
\n                             ; 
[ \t]                          ;
.                              ;


