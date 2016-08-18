#include <stdio.h>

struct shit
{
};

typedef struct fuck
{
    union
    {
        int    numi;
        double numd;
    };
    const char* name;
}
fuck;

int main()
{
    fuck fucks[] = {{123, "1231"}, {3245, "2345"}, {0, 0}};

    for (int i = 0; fucks[i].numi != 0; ++i)
    { 
        printf("%d  %s\n", fucks[i].numi, fucks[i].name);
    }

    int a, b;

    a = b = 1;

    return 0;
}
