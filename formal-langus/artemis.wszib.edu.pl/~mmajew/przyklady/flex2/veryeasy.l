%{
/* veryeasy.l 
   demonstruje wykorzystanie dyrektywy REJECT */
%}

%%

very      printf("%s ",yytext);  REJECT;
[a-z]+    ECHO;

