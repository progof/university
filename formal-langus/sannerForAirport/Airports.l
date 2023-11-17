%{
#include <stdio.h>
#include <string.h>
%}

%option noyywrap

%%
\n          { return yytext[0]; }
[^,\n]+     { printf("%s, %s\n", yytext, country); }
,           { /* ignore commas */ }
%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <country>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen("Lotniska.csv", "r");
    if (!file) {
        perror("Unable to open Lotniska.csv");
        return 1;
    }

    char *country = argv[1];
    yyin = file;
    yylex();

    fclose(file);

    return 0;
}
