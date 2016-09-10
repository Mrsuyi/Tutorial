%option noyywrap

%{
#include <stdio.h>
%}

 /* 0xxx-xxxx  [0000-0000 => 0100-0000] i.e. ASCII */
H1 [\x00-\x7f]
 /* 110x-xxxx  [1100-0010 => 1101-1111] */
H2 [\xc2-\xdf]
 /* 1110-xxxx  [1110-0000 => 1110-1111] */
H3 [\xe0-\xef]
 /* 1111-0xxx  [1111-0000 => 1111-0100] */
H4 [\xf0-\xf4]

 /* 10xx-xxxx  [1000-0000 => 1011-1111] trailing after Ux */
B  [\x80-\xbf]

U1 {H1}
U2 {H2}{B}
U3 {H3}{B}{B}
U4 {H4}{B}{B}{B}

%%

{U1}  { printf("1 byte %s\n", yytext); }
{U2}  { printf("2 byte %s\n", yytext); }
{U3}  { printf("3 byte %s\n", yytext); }
{U4}  { printf("4 byte %s\n", yytext); }

%%

int main()
{
    yylex();
}
