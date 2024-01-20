%{

/* identyfikatory.l
   Program rozpoznaje identyfikatory, liczby calkowite i liczby rzeczywiste
   oraz wypisuje na wyjscie informacje, w ktorej linii pliku wejsciowego sie one znajduja */

int linia;
%}

ID       [a-zA-Z][a-zA-Z0-9]*
NUMBER   [0-9]+
REAL     [0-9]+\.[0-9]+
%%

{ID}			printf("Identyfikator %s w linii %d\n", yytext, linia);
{NUMBER}		printf("Liczba calkowita %s w linii %d\n", yytext, linia);
{REAL}			printf("Liczba rzeczywista  %s w linii %d\n", yytext, linia);

\n			linia++; 
.  			;

%%

int main () {
	linia = 1;
	yylex(); 
	printf("---> Przeczytano %d linie\n", linia);
	return 0;
}
