%{
/* shutdown.l
   dopasowuje ciag znakow "shut", jezeli wystapi po nim ciag znakow "down" */
%}

%%

shut/down	 printf("%s\n", yytext);
.|\n		 /* empty */

