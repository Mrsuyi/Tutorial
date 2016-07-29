#include "stdio.h"
#include "stdarg.h"

int sum(int cnt, ...)
{
    int ret = 0;

    va_list args;
    
    // init args
    va_start(args, cnt);

    for (int i = 0; i < cnt; ++i)
    {
        // pick out one arg
        ret += va_arg(args, int); 
    }

    // clean up memory for args
    va_end(args);

    return ret;
}

int main()
{
    printf("%d\n", sum(3, 1, 2, 3));
    printf("%d\n", sum(4, 1, 2, 3, 4));
    printf("%d\n", sum(5, 1, 2, 3, 4, 5));

    return 0;
}
