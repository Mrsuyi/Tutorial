#include <errno.h>
#include <error.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>

int
main()
{
    char f_path[] = "shit.txt";

    int fileno = open(f_path, O_RDWR);

    if (fileno == -1)
    {
        printf("open %s error: %s\n", f_path, strerror(errno));
    }

    return 0;
}
