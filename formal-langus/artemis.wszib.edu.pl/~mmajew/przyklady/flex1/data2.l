
%{
/* data2.l
   Program analizuje strumien wejsciowy 
   i wypisuje na wyjscie date w postaci dd-mm-rrrr */


%}

C 	[0-9]


%%

{C}{2}"."{C}{2}"."{C}{4}	printf("Znaleziono date: %s\n",yytext);

.	 			|
\n				;

