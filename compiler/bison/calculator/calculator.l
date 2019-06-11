%option noyywrap
%option always-interactive

%{
#include <stdio.h>
#include "calculator.parser.h"
%}

DIGIT    [0-9]
WORD     [0-9a-zA-Z_]
BLANK    [ \t]
OPERATOR [+\-*/\^]

%%

[ \t]                 { ; }
{DIGIT}+(\.{DIGIT}+)? { yylval.valf = atof(yytext); return NUM; }
[+\-*/\^\n]           { return *yytext; }
<<EOF>>               { return '\0'; }
.                     { ; }

%%
