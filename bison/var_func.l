%option noyywrap

%{
#include <stdio.h>
#include "var_func.tab.h"
%}

DIGIT    [0-9]
WORD     [0-9a-zA-Z_]
BLANK    [ \t]
OPERATOR [\(\)=+\-*/\^]

%%

{DIGIT}+(\.{DIGIT}+)? { yylval.valf = atof(yytext); return NUM; }
{WORD}+               { yylval.vals = strdup(yytext); return VAR; }
 /*
b{DIGIT}+\.{DIGIT}+ { yylval = atof(yytext); return NUM; }
o{DIGIT}+\.{DIGIT}+ { yylval = atof(yytext); return NUM; }
h{DIGIT}+\.{DIGIT}+ { yylval = atof(yytext); return NUM; }
*/

{OPERATOR}|\n { return *yytext; }

<<EOF>> { return '\0'; }

. { ; }

%%
