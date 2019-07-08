%option noyywrap

%{
#include <stdio.h>

int    vali;
double vald;
char*  vals;

#define INT    256 
#define DOUBLE 257
#define STRING 258
%}

DIGIT [0-9]
WORD  [0-9a-zA-Z_]
BLANK [ \t\n]

%%

{BLANK}            ;
{DIGIT}+\.{DIGIT}+ vald = atof(yytext);   return DOUBLE;
{DIGIT}+           vali = atoi(yytext);   return INT;
{WORD}+            vals = strdup(yytext); return STRING;
.                  printf("wtf???\n");
<<EOF>>            printf("end of file\n"); yyterminate();

%%

int main()
{
    int type;
    while (type = yylex())
    {
        switch (type)
        {
            case INT:
                printf("integer!!! %d\n", vali + 1);
                break;
            case DOUBLE:
                printf("double!!! %f\n", vald + 1);
                break;
            case STRING:
                vals[0] = '@';
                printf("string!!! %s\n", vals);
                free(vals);
                break;
            default:
                ;
        }
    }
    return 0;
}
