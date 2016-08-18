%option noyywrap

%{
#include <stdio.h>
#include "calculator.tab.h"
%}

DIGIT    [0-9]
WORD     [0-9a-zA-Z_]
BLANK    [ \t]
OPERATOR [+\-*/\^]

%%

{DIGIT}+(\.{DIGIT}+)? { yylval.valf = atof(yytext); return NUM; }
 /*
b{DIGIT}+\.{DIGIT}+ { yylval = atof(yytext); return NUM; }
o{DIGIT}+\.{DIGIT}+ { yylval = atof(yytext); return NUM; }
h{DIGIT}+\.{DIGIT}+ { yylval = atof(yytext); return NUM; }
*/

{OPERATOR}|\n { return *yytext; }

<<EOF>> { return '\0'; }

. { ; }

%%
