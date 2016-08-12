#include "stdio.h"
#include "stdarg.h"

int sum(int cnt, ...)
{
    int ret = 0;

    va_list argptr;
    
    // init argptr
    va_start(argptr, cnt);

    for (int i = 0; i < cnt; ++i)
    {
        // pick out one arg
        ret += va_arg(argptr, int); 
    }

    // clean up memory for argptr
    va_end(argptr);

    return ret;
}

void print(const char* format, ...)
{
    va_list argptr;
    va_start(argptr, format);
    vfprintf(stdout, format, argptr);
    va_end(argptr);
}

int main()
{
    printf("%d\n", sum(3, 1, 2, 3));
    printf("%d\n", sum(4, 1, 2, 3, 4));
    printf("%d\n", sum(5, 1, 2, 3, 4, 5));
 
    print("%d%d%d\n", 1, 2, 3);

    return 0;
}
