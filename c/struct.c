#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    int num;
    char tail[];
} shit;

void
array_tail()
{
    assert(sizeof(shit) == 4);

    shit* s = (shit*)malloc(sizeof(shit) + 5);

    s->tail[0] = 's';
    s->tail[1] = 'h';
    s->tail[2] = 'i';
    s->tail[3] = 't';
    s->tail[4] = 0;

    printf("%s\n", s->tail);

    free(s);
}

typedef struct fuck
{
    union {
        int numi;
        double numd;
    };
    const char* name;
} fuck;

void
brace_init()
{
    fuck fucks[] = {{{123}, "1231"}, {{3245}, "2345"}, {{0}, 0}};

    for (int i = 0; fucks[i].numi != 0; ++i)
    {
        printf("%d  %s\n", fucks[i].numi, fucks[i].name);
    }
}

int
main()
{
    array_tail();
    brace_init();

    return 0;
}
