%{
#include <stdio.h>
#include "hello.lexer.h" /* defines yylex yyin yy_scan_buffer ... */

void yyerror(char* s)
{
    printf("%s\n", s);
}
%}

%define api.value.type { int }

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
