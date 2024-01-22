%{
#include <stdio.h>
#include <string.h>
%}

%option noyywrap


%%
[ \t\n]+              /* Ignore whitespace */
"lp;"                 { /* Ignore header line */ }
[0-9]+ ";"            { /* Ignore numeric entries */ }
\"([^"]*)\";          { // String value
                        char str_value[256];
                        strncpy(str_value, yytext + 1, yyleng - 2);
                        str_value[yyleng - 2] = '\0';
                        printf("%s, ", str_value);
                      }
";"                   { printf("\n"); }
kraj:([^;]+);miasto:([^;]+);.*$ { wypisz_lotniska(yytext + 5, yytext + 18); }
.                     { /* Ignore any other characters */ }
%%

int main(int argc, char** argv) {
    if (argc != 2) {
        fprintf(stderr, "Użycie: %s <kraj>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen("Lotniska.csv", "r");
    if (!file) {
        perror("Błąd przy otwieraniu pliku Lotniska.csv");
        return 1;
    }

    // Ustawienie dostarczanego przez flex wejścia na plik
    yyin = file;

    // Parsowanie pliku Lotniska.csv
    yylex();

    // Zamykanie pliku
    fclose(file);

    return 0;
}


void wypisz_lotniska(char* kraj, char* miasto) {
    printf("%s, %s\n", miasto, kraj);
}
