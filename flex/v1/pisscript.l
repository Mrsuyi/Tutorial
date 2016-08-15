%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
%}

%%

[ \t\n]        ;
[0-9]+\.[0-9]+ { cout << "found a float" << endl; }
[0-9]+         { cout << "found a integer" << endl; }
[a-zA-Z0-9]+   { cout << "found a string" << endl; }

%%

int main()
{
    yylex();
}
