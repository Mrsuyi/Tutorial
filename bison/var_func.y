%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>

void yyerror(char* s)
{
    printf("shit: %s\n", s);
}

typedef double (*function)(double);

typedef struct var
{
    char* name;
    union
    {
        double   num;
        function func;
    };
    struct var* next;
}
var;

var* list = NULL;

var* var_new(const char* name)
{
    var* v  = malloc(sizeof(var));
    v->num  = 0;
    v->name = malloc(strlen(name) + 1);
    strcpy(v->name, name);
    return v;
}

void var_delete(var* v)
{
    free(v->name);
    free(v);
}

var* var_put(const char* name)
{
    var* v = var_new(name);
    v->next = list;
    list = v;
    return list;
}

var* var_get(const char* name)
{
    var* tmp = list;
    while (tmp)
    {
        if (!strcmp(name, tmp->name))
        {
            return tmp;
        }
        tmp = tmp->next;
    }
    return var_put(name);
}

%}

%union {
    int    vali;
    double valf;
    char*  vals;
}

%token <valf> NUM
%token <vals> VAR

%type  <valf> exp

%left '='
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
   | VAR               { $$ = var_get($1)->num; }
   | VAR '=' exp       { $$ = var_get($1)->num = $3; }
   | VAR '(' exp ')'   { $$ = var_get($1)->func($3); }
   | exp '+' exp       { $$ = $1 + $3; }
   | exp '-' exp       { $$ = $1 - $3; }
   | exp '*' exp       { $$ = $1 * $3; }
   | exp '/' exp       { $$ = $1 / $3; }
   | '-' exp %prec NEG { $$ = -$2; }
   | exp '^' exp       { $$ = pow($1, $3); }
   | '(' exp ')'       { $$ = $2; }
   ;

%%

int main()
{
    const char* func_name[] = { "sin", "cos" , "log", "exp", "atan", "sqrt" };
    function    func_ptr[]  = { sin, cos, log, exp, atan, sqrt };

    for (int i = 0; i < 6; ++i)
    {
        var* v = var_put(func_name[i]);
        v->func = func_ptr[i];
    }

    yyparse();

    while (list)
    {
        var* tmp = list->next;
        var_delete(list);
        list = tmp;
    }

    return 0;
}
