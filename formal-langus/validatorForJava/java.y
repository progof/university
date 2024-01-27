%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
%}

%error-verbose
%token IF ELSE IDENTIFIER NUMBER EQ NEQ LEQ GEQ PRINT STRING GREATER_OPEN GREATER_CLOSE ASSIGNMENT_OP PAREN_OPEN PAREN_CLOSE LBRACE RBRACE SEMICOLON

%left ADD_OP SUB_OP
%left MUL_OP DIV_OP

%%

program: /* empty */
       | program block
       | program statement
       ;

block: statement 
     {
          printf("\nSuccess: Valid block\n");
      }
    | LBRACE RBRACE
     {
          printf("\nSuccess: Valid empty block\n");
      }
    ;    

statement: if_statement
         | assignment_statement
         | print_statement
         | LBRACE program RBRACE
         ;

if_statement: IF PAREN_OPEN condition PAREN_CLOSE statement %prec GEQ
            {
                printf("\nSuccess: If statement with condition\n");
            }
          | IF PAREN_OPEN condition PAREN_CLOSE statement ELSE statement
            {
                printf("\nSuccess: If-else statement\n");
            }
            ;

condition: expression EQ expression
         | expression NEQ expression
         | expression GREATER_OPEN expression
         | expression GREATER_CLOSE expression
         | expression LEQ expression
         | expression GEQ expression
         {
             printf("\nSuccess: Valid condition\n");
         }
         ;

expression: IDENTIFIER
          | NUMBER
          | expression ADD_OP expression
          | expression SUB_OP expression
          | expression MUL_OP expression
          | expression DIV_OP expression
          {
              printf("\nSuccess: Valid expression\n");
          }
          ;

assignment_statement: IDENTIFIER ASSIGNMENT_OP expression SEMICOLON
                   {
                       printf("\nSuccess: Assignment statement\n");
                   }
                   ;

print_statement: PRINT PAREN_OPEN STRING PAREN_CLOSE SEMICOLON
               {
                   printf("\nSuccess: Print statement\n");
               }
               ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
    exit(1);
}


