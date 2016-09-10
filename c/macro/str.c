#include "stdio.h"

#define STR(x)    #x
#define STR_(x)   STR(x)
#define CAT(x, y) STR(x##y)

#define ONE_EXPANSION STR(__LINE__)
#define TWO_EXPANSION STR_(__LINE__)

int main()
{   
    printf("a simple string: %s\n", STR(a simple string));
    printf("two word: %s\n", CAT(two, word));
    printf("expand __LINE__ once will produce %s\n", ONE_EXPANSION);
    printf("expand __LINE__ twice will produce %s\n", TWO_EXPANSION);
}
