%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
%}

%error-verbose
%token INT IF ELSE IDENTIFIER NUMBER EQ NEQ LEQ GEQ PRINT STRING GREATER_OPEN GREATER_CLOSE ASSIGNMENT_OP PAREN_OPEN PAREN_CLOSE LBRACE RBRACE SEMICOLON INC_OP DEC_OP

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
    | LBRACE program RBRACE
     {
          printf("\nSuccess: Valid empty block\n");
      }
    ;    


statement: if_statement
         | assignment_statement
         | declaration_statement
         | print_statement
         | increment_statement
         | decrement_statement
         | LBRACE program RBRACE
         ;


if_statement: IF PAREN_OPEN condition PAREN_CLOSE block
            {
                printf("\nSuccess: If statement with condition\n");
            }
            | IF PAREN_OPEN condition PAREN_CLOSE block ELSE block
            {
                printf("\nSuccess: If-else statement\n");
            }
            | ELSE IF PAREN_OPEN condition PAREN_CLOSE block ELSE block
            {
                printf("\nSuccess: Else-if statement\n");
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
               | PRINT PAREN_OPEN STRING ADD_OP IDENTIFIER PAREN_CLOSE SEMICOLON
               {
                   printf("\nSuccess: Print statement with value\n");
               }
               ;

declaration_statement: INT IDENTIFIER ASSIGNMENT_OP NUMBER SEMICOLON
                   {
                       printf("\nSuccess: Declaration statement\n");
                   }
                   ;   

increment_statement: IDENTIFIER INC_OP SEMICOLON
                    {
                       printf("\nSuccess: Increment statement\n");
                    }
                   ;

decrement_statement: IDENTIFIER DEC_OP SEMICOLON
                    {
                       printf("\nSuccess: Decrement statement\n");
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


