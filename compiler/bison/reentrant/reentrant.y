%{
#include <stdio.h>
#include "reentrant.lexer.h"

void yyerror(yyscan_t scanner, char* s)
{
    printf("%s\n", s);
}
%}

%define api.pure full
%define api.value.type { int }

%lex-param   { yyscan_t scanner }
%parse-param { yyscan_t scanner }

%token INT

%%

input: /* empty */
     | input INT       { printf("get an integer: %d\n", $2); }
     | input error INT { yyerrok; }
     ;

%%

int main()
{
    yyscan_t scanner;
    yylex_init(&scanner);
    yyparse(scanner);
    yylex_destroy(scanner);
    return 0;
}
