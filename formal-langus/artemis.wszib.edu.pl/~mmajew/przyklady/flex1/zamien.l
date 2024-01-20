%{
/* Program wyszukuje ciag znakow "lex"
   i zamienia go na na ciag znakow "flex" */
%}

%%

lex   printf("flex");

%%
int main() {
  printf("Zamiana ciagu znakow lex na flex:\n");
  yylex();
  return 0;
}
