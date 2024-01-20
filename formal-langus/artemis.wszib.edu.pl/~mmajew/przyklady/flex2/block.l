%{
/*  block.l 
    Zliczanie wystapien ciagow znakow block i lock  */

int block_c = 0, lock_c = 0;
%}

%%

block   {
	    block_c++;
	    /* Po dopasowaniu ciagu block wycofaj
	    wszystkie znaki poza pierwszym do ponownej analizy */
	    yyless(1);
	}

lock		lock_c++;

\n|.		/* empty */

%%

int main(){
   
   yyout = fopen("scanner_output", "a+");
   yylex();
   fprintf(yyout, "block - %d, lock - %d\n",  block_c, lock_c);
   fclose(yyout);
}
