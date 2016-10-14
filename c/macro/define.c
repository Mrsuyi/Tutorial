#include <stdio.h>

#define NUM 100

void func1()
{
    printf("%d\n", NUM);
}

#ifdef NUM
    #undef  NUM
    #define NUM 200
#else
    #define NUM 100
#endif

void func2()
{
    printf("%d\n", NUM);
}

#if NUM > 100
    #undef NUM
    #define NUM 300
#endif

void func3()
{
    printf("%d\n", NUM);
}

int main()
{
    func1();
    func2();
    func3();
}
