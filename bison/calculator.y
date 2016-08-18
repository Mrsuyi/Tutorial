%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%union {
    int    vali;
    double valf;
    char*  vals;
}

%token <valf> NUM

%type  <valf> exp

%left '+' '-'
%left '*' '/'
%left NEG
%right '^'

%%

input: /* empty */
     | input line
     ;

line: '\n'
	| exp '\n'   { printf("%.10g\n", $1); }
    | error '\n' { yyerrok; }
	;

exp: NUM               { $$ = $1; }
   | exp '+' exp       { $$ = $1 + $3; }
   | exp '-' exp       { $$ = $1 - $3; }
   | exp '*' exp       { $$ = $1 * $3; }
   | exp '/' exp       { $$ = $1 / $3; }
   | '-' exp %prec NEG { $$ = -$2; }
   | exp '^' exp       { $$ = pow($1, $3); }
   | '(' exp ')'       { $$ = $2; }
   ;

%%

void yyerror(char* s)
{
    printf("shit: %s\n", s);
}

int main()
{
    yyparse();
    return 0;
}
