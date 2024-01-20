
%{
/* data1.l
   Program analizuje strumien wejsciowy 
   i wypisuje na wyjscie date w postaci dd-mm-rrrr */
%}

%%

[0-9]{2}"."[0-9]{2}"."[0-9]{4}	printf("Znaleziono date: %s\n",yytext); 

. 	|
\n	;




