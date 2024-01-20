/* examplelex.l - skaner wspolpracujacy z parserem example.y */

%%
[a-z]   { yylval = yytext[0];
          return T_CHAR;
        }

.|\n   ;
