%{
  #include <stdio.h>
  void yyerror(char *);
  extern int yylineno;
  int yylex ();
%}

%token TYP ID

%%

instrukcje : instrukcje instrukcja
        | /* pusta reguła */
        ;

instrukcja : deklaracja ';'  { printf("\t\t\tLinia %d: Poprawna instrukcja\n", yylineno); }
           | error ';'       { yyerror("Niepoprawna instrukcja"); }
           ;

deklaracja : TYP ID
           ;


%%

void yyerror(char * s) {
   printf("\t\t\tLinia %d: Blad %s\n", yylineno, s);
}

int main(){
   yyparse();
}
