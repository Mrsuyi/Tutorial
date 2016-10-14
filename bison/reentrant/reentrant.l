%option noyywrap
%option always-interactive
%option reentrant
%option bison-bridge

/*
   this will be put into generated header
   because yylex yyget_lval yyset_lval need YYSTYPE as argument
*/
%top {
#define YYSTYPE int
}

%{
#include <stdio.h>
#include "reentrant.parser.h"
%}

DIGIT [0-9]
WORD  [0-9a-zA-Z_]
BLANK [ \t\n]

%%

{DIGIT}+ { *yylval = atoi(yytext); return INT; }
.        { ; }

%%
