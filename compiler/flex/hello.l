%option noyywrap

%{
#include <stdio.h>
%}

%%

fuck { printf("you just typed 'fuck' ???\n"); }
.    { printf("you just typed: %s\n", yytext); }

%%

int main()
{
    yylex();
}
