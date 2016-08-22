%{
#include<iostream>
#include <cstdlib>

using namespace std;
%}

%option nodefault
%option noyywrap
%option c++
%option yyclass="Lexer"
%option prefix="mrsuyi_"

%%

[a-z]+ { cout << "word: " << yytext << endl; return 1; }

.      { cout << "unknown character: " << yytext << endl; return 2; }

<<EOF>> { return yyterminate(); }

%%
