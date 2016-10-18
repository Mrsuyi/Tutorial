#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handler(int signo)
{
    switch (signo)
    {
        case SIGUSR1:
            printf("SIGUSR1 received\n");
            signal(SIGUSR1, handler);
            break;
        case SIGUSR2:
            printf("SIGUSR2 received\n");
            signal(SIGUSR2, handler);
            break;
        default:
            ;
    }
}

int main()
{
    if (signal(SIGUSR1, handler) == SIG_ERR)
    {
        printf("can't catch SIGURS1");
    }
    if (signal(SIGUSR2, handler) == SIG_ERR)
    {
        printf("can't catch SIGURS2");
    }

    while (1)
        pause();

    return 0;
}

