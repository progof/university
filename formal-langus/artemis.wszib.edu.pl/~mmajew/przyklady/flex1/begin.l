%{
/* begin.l
   Skaner rozpoznaje slowa kluczowe begin */
%}

%%

begin    printf("slowo kluczowe: %s\n", yytext);   // regula 1 
[a-z]+   printf("identyfikator: %s\n", yytext);    // regula 2 
.|\n     /* empty */

