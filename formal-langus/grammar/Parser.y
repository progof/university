%{
#include <stdio.h>
%}

%token IDENTIFIER
%token ASSIGNMENT_OP
%token ADD_OP SUB_OP MUL_OP DIV_OP INC_OP DEC_OP
%token SEMICOLON

%%

block: '{' statement_list '}'
     ;

statement_list: statement
              | statement_list statement
              ;

statement: assignment_statement
         | increment_statement
         | decrement_statement
         | expression_statement
         ;

assignment_statement: IDENTIFIER ASSIGNMENT_OP expression SEMICOLON
                   ;

increment_statement: IDENTIFIER INC_OP SEMICOLON
                  ;

decrement_statement: IDENTIFIER DEC_OP SEMICOLON
                  ;

expression_statement: expression SEMICOLON
                   ;

expression: IDENTIFIER
          | expression ADD_OP expression
          | expression SUB_OP expression
          | expression MUL_OP expression
          | expression DIV_OP expression
          ;

%%

int main() {
    yyparse();
    return 0;
}
