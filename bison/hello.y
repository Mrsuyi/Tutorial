%{
#define YYSTYPE int
#include <stdio.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
%}

%token INT

%%

input: /* empty */
     | input INT       { printf("get an integer: %d\n", $2); }
     | input error INT { yyerrok; }
     ;

%%

void yyerror(char* s)
{
    printf("%s\n", s);
}

int main()
{
    yyparse();
    return 0;
}
