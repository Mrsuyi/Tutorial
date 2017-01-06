#include <errno.h>
#include <glob.h>
#include <stdio.h>
#include <string.h>

int
main(int argc, char** argv)
{
    glob_t glob_res;

    for (int i = 1; i < argc; ++i)
    {
        printf("[%s]\n", argv[i]);

        if (glob(argv[i], GLOB_TILDE, NULL, &glob_res) != 0)
        {
            printf("glob fail: %s\n", strerror(errno));
        }
        else
        {
            for (size_t j = 0; j < glob_res.gl_pathc; ++j)
            {
                printf("\t%s\n", glob_res.gl_pathv[j]);
            }
        }
    }
    globfree(&glob_res);

    return 0;
}
