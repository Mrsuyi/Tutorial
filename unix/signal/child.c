#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

void handler(int signo)
{
    pid_t pid;
    int   status;

    printf("SIGCLD received\n");

    if (signal(SIGCLD, handler) == SIG_ERR)
    {
        printf("signal error\n");
    }
    if ((pid = wait(&status)) < 0)
    {
        printf("wait error\n");
    }

    printf("pid = %d\n", pid);
}

int main()
{
    pid_t pid;

    if (signal(SIGCLD, handler) == SIG_ERR)
    {
        printf("signal error\n");
    }
    if ((pid = fork()) < 0)
    {
        printf("fork error\n");
    }
    else if (pid == 0)
    {
        sleep(2);
        _exit(0);
    }
    
    pause();
    exit(0);
}

