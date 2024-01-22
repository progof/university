%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
%}

%token IF ELSE IDENTIFIER NUMBER EQ NEQ LEQ GEQ PRINT STRING

%%

program: /* empty */
       | program statement
       ;

statement: if_statement
         | assignment_statement
         | print_statement
         ;

if_statement: IF '(' condition ')' statement %prec GEQ
            | IF '(' condition ')' statement ELSE statement
            ;

condition: expression EQ expression
         | expression NEQ expression
         | expression '<' expression
         | expression '>' expression
         | expression LEQ expression
         | expression GEQ expression
         ;

expression: IDENTIFIER
          | NUMBER
          | expression '+' expression
          | expression '-' expression
          | expression '*' expression
          | expression '/' expression
          ;

assignment_statement: IDENTIFIER '=' expression ';'
                   ;

print_statement: PRINT '(' STRING ')' ';'
               ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
    exit(1);
}


