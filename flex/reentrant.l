%option reentrant noyywrap

%%

. { printf("%s\n", yytext); }

%%

int main()
{
    yyscan_t scanner;
    yylex_init(&scanner);

    yylex(scanner);

    yylex_destroy(scanner);

    return 0;
}
