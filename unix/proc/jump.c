#include <stdio.h>
#include <setjmp.h>

jmp_buf buf;

void func1();
void func2();

int main()
{
    switch (setjmp(buf))
    {
        case 0:
            printf("execute direcly\n");
            break;
        case 1:
            printf("return from func1\n");
            break;
        case 2:
            printf("return from func2\n");
            break;
        default:
            printf("unknown result\n");
            ;
    }

    func1();

    return 0;
}

void func1()
{
    printf("enter func1, jump back? (y/n):\n");

    char c = getchar(); getchar();
    if (c == 'y')
    {
        longjmp(buf, 1);
    }

    func2();
}

void func2()
{
    printf("enter func2, jump back? (y/n):\n");
    
    char c = getchar(); getchar();
    if (c == 'y')
    {
        longjmp(buf, 2);
    }

    printf("finish func2\n");
}
