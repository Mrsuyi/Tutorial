%option noyywrap
%option always-interactive

%{
#include <stdio.h>
#include "var.parser.h"
%}

DIGIT    [0-9]
WORD     [0-9a-zA-Z_]

%%

[ \t]                      { ; }
\n                         { return '\n'; }
TRUE|true                  { return TRUE; }
FALSE|false                { return FALSE; }
{DIGIT}+(\.{DIGIT}+)?      { yylval.valf = atof(yytext); return NUM; }
{WORD}+                    { yylval.vals = strdup(yytext); return VAR; }
\=\=                       { return EQ; }
\!\=                       { return NEQ; }
\<\=                       { return SEQ; }
\>\=                       { return BEQ; }
\&\&                       { return AND; }
\|\|                       { return OR; }
[\+\-\*/%&\|\^\!\(\)=<>]   { return *yytext; }
<<EOF>>                    { return '\0'; }
.                          { ; }

%%
