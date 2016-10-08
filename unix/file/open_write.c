#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
    char a[] = "shit";
    
    int f = open("test.txt", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);

    printf("write %i\n", (int)write(f, a, sizeof(a)));

    char b[] = "213321123123";

    lseek(f, 0, SEEK_SET);

    int cnt = (int)read(f, b, sizeof(b));
    printf("read %d\n", cnt);

    printf("content: %s\n", b);

    close(f);

    return 0;
}
