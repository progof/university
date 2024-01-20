%{
#include <stdio.h>
int yylex(void);
int yyerror(const char *);
%}
%error-verbose
%token INCREMENT DECREMENT SEMICOLON DIV_OP ADD_OP SUB_OP MUL_OP INC_OP ASSIGNMENT_OP DEC_OP INTEGER IDENTIFIER LBRACE RBRACE

%left ADD_OP SUB_OP
%left MUL_OP DIV_OP
%%
program: /* empty */
       | program block
       ;

block: LBRACE statements RBRACE
     {
          printf("Success: Valid block\n");
      }
    | LBRACE RBRACE
     {
          printf("Success: Valid empty block\n");
      }
    ;      

statements:
          | statements statement
          | statement
          ;

statement: assignment SEMICOLON
         | increment SEMICOLON
         | decrement SEMICOLON
         | expression SEMICOLON
         ;


assignment: identifier ASSIGNMENT_OP expression
          ;

increment: 
    identifier INC_OP
    ;

decrement: 
    identifier DEC_OP
    ;

expression: identifier
    | INTEGER
    | expression ADD_OP expression
    | expression SUB_OP expression
    | expression MUL_OP expression
    | expression DIV_OP expression
    ;

identifier: IDENTIFIER;
%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}



