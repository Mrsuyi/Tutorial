#include <stdio.h>
#include <stdlib.h>

extern char** environ;

int main()
{
    char* path = getenv("PATH");

    if (path != NULL)
    {
        printf("%s\n", path);
    }

    for (char** env = environ; env != NULL; ++env)
    {
        printf("%s\n", *env);
    }
 
    return 0;
}

