%option noyywrap
%option always-interactive

%{
#include <stdio.h>
#include "hello.parser.h"
%}

DIGIT [0-9]
WORD  [0-9a-zA-Z_]
BLANK [ \t\n]

%%

{DIGIT}+ { yylval = atoi(yytext); return INT; }
.        { ; }

%%
