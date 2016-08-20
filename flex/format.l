 /*** definition section ***/ 

 /* comment block should begin with one or more space */

%option noyywrap

 /* everything begin with indent will be copied to output */
    #define SHIT 100
    #define FUCK 200
 /* so does %{...%} */
%{
#include <stdio.h>
#define FUCK 200
#define YY_DECL extern "C" int yylex()
%}

 /* %top{...} will be copied to the top of output */ 
%top {
#define THIS_IS_TOP
#include <math.h>
}

 /* these definitions are used like c-macros */
DIGIT [0-9]
WORD  [0-9a-zA-Z_]
BLANK [ \t\n]

%%
 /*** rules section ***/

{DIGIT}+           printf("integer: %s\n", yytext);
{DIGIT}+\.{DIGIT}+ printf("float: %s\n", yytext);
{WORD}+            printf("string: %s\n", yytext);
{BLANK}+           ;
.                  printf("what the fuck?\n");

%%
 /*** user code section ***/

int main()
{
    yylex();
    return 0;
}
