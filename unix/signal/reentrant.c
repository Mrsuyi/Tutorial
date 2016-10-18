#include <pwd.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void
handler(int signo)
{
    if (signal(SIGALRM, handler) == SIG_ERR)
    {
        printf("signal error\n");
    }

    struct passwd* ptr;

    printf("in handler\n");
    if ((ptr = getpwnam("root")) == NULL)
    {
        printf("getpwnam error\n");
    }
    alarm(1);
}

int
main()
{
    struct passwd* ptr;

    signal(SIGALRM, handler);
    if (signal(SIGALRM, handler) == SIG_ERR)
    {
        printf("signal error\n");
    }
    alarm(1);

    for (;;)
    {
        if ((ptr = getpwnam("mrsuyi")) == NULL)
        {
            printf("getpwnam error\n");
        }
        if (strcmp(ptr->pw_name, "mrsuyi") != 0)
        {
            printf("return value corrupted, pw_name = %s\n", ptr->pw_name);
        }
        pause();
    }

    return 0;
}
