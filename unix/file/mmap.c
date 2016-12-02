#include "../debug.h"

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

char f_path[] = "data.txt";
char content[] = "fucking shit";
off_t len = 1024 * 1024;

void
create()
{
    // create
    int fileno = open(f_path, O_RDWR | O_CREAT | O_TRUNC, (mode_t)0660);
    if (fileno == -1) fail("open %s error\n", f_path);

    int res = ftruncate(fileno, len);
    if (res != 0) fail("truncate %s to %ld bytes error\n", f_path, len);

    void* pmmap = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fileno, 0);
    if (pmmap == MAP_FAILED)
        fail("truncate %s to %ld bytes error\n", f_path, len);

    // write
    memcpy(pmmap, content, sizeof(content));

    // close
    res = munmap(pmmap, len);
    if (res != 0) fail("munmap %s failed", f_path);
    res = close(fileno);
    if (res != 0) fail("close %s failed", f_path);
}

int
main()
{
    create();

    return 0;
}
