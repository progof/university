%{
#include <stdio.h>
#include <string.h>

// Zmienne globalne
int printing = 0;  // Flaga wypisywania danych dla danego kraju
char kraj[256];     // Przechowuje kraj, dla którego szukamy lotnisk
%}

%option noyywrap

%%
\"[^\n]*\n  // Ignoruj całe linie danych (np. nagłówki)
[0-9]+;[0-9]+;\"   // Ignoruj pierwsze dwa pola danych

[^;]+;[^;]+;      // Odczytaj kraj i miasto
{
    if (printing) {
        // Sprawdź, czy kraj pasuje do poszukiwanego kraju
        if (strstr(yytext, kraj)) {
            printf("%s, %s\n", yytext, yytext);
        }
    }
}

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Użycie: %s <kraj>\n", argv[0]);
        return 1;
    }

    // Przypisz kraj z argumentu
    strcpy(kraj, argv[1]);

    // Uruchom analizator leksykalny
    yylex();

    return 0;
}
