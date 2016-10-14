#include <stdio.h>
#include <getopt.h>

static const char* op_short = "ab:c::";

static const struct option op_long[] =
{
    { "shit", no_argument, NULL, 'S' },
    { "fuck", required_argument, NULL, 'F' }
};


void shorter(int argc, char* argv[])
{
    int option;
    while ((option = getopt(argc, argv, op_short)) != -1)
    {
        printf("option: %d\n", option);
        
        switch (option)
        {
            case 'a':
                printf("-a\n");
                break;

            case 'b':
                printf("-b %s\n", optarg);
                break;

            case 'c':
                printf("-c %s\n", optarg);
                break;

            default:
                ;
        }
    }
}

void longer(int argc, char* argv[])
{
    int option;
    int longIndex;
    while ((option = getopt_long(argc, argv, op_short, op_long, &longIndex)) != -1)
    {
        printf("option: %d\n", option);

        switch (option)
        {
            case 'a':
                printf("-a\n");
                break;

            case 'b':
                printf("-b %s\n", optarg);
                break;

            case 'c':
                printf("-c %s\n", optarg);
                break;

            case 'S':
                printf("--shit %s\n", optarg);
                break;

            case 'F':
                printf("--fuck %s\n", optarg);
                break;

            default:
                ;
       }
    }
}

int main(int argc, char* argv[])
{
    /*shorter(argc, argv);*/
    longer(argc, argv);

    return 0;
}

