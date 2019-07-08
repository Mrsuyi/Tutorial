%{
#define YYSTYPE int
#include <stdio.h>

#include "hello.lexer.h"

void yyerror(char* s)
{
    printf("%s\n", s);
}
%}

%token INT

%%

input: /* empty */
     | input INT       { printf("get an integer: %d\n", $2); }
     | input error INT { yyerrok; }
     ;

%%

int main()
{
    yyparse();
    return 0;
}
