#include <pwd.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void
handler(int signo)
{   
    printf("alarm\n");
    signal(SIGALRM, handler);
    if (signal(SIGALRM, handler) == SIG_ERR)
    {
        printf("signal error\n");
    }
    alarm(1);
}

int
main()
{
    signal(SIGALRM, handler);
    if (signal(SIGALRM, handler) == SIG_ERR)
    {
        printf("signal error\n");
    }
    alarm(1);

    for (;;)
    {
        pause();
    }

    return 0;
}
