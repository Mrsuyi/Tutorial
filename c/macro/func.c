#include "stdio.h"

//==================== function single line ====================//
#define MUL1(x) x*x
#define MUL2(x) (x)*(x)

#define ADD1(x) (x)+(x)
#define ADD2(x) ((x)+(x))
#define ADD3(x) ({ __typeof__(x) __x = (x); __x + __x; })

void func_single_line()
{
    printf("expect %d, got %d\n", (1 + 2) * (1 + 2), MUL1(1 + 2)); // 1+2*1+2
    printf("expect %d, got %d\n", (1 + 2) * (1 + 2), MUL2(1 + 2));

    printf("expect %d, got %d\n", (1 + 1) * (1 + 1), ADD1(1) * ADD1(1)); // (1)+(1)*(1)+(1)
    printf("expect %d, got %d\n", (1 + 1) * (1 + 1), ADD2(1) * ADD2(1));

    int i = 1;
    printf("expect %d, got %d\n", (2 + 2), ADD2(++i)); // (++i)+(++i)
    i = 1;
    printf("expect %d, got %d\n", (2 + 2), ADD3(++i));
}

//==================== function multiple line ====================//

// this cannot handle
//      if (true)
//          FUNC1;
#define FUNC1(num) printf("%d\n", num); \
                   printf("%d\n", num + 1); \
                   printf("%d\n", num + 2);

// this cannot handle
//      if (true)
//          FUNC2;
//      else
//          ;
#define FUNC2(num) { \
                       printf("%d\n", num); \
                       printf("%d\n", num + 1); \
                       printf("%d\n", num + 2); \
                   }

// this is fine :D
#define FUNC3(num) do \
                   {  \
                       printf("%d\n", num); \
                       printf("%d\n", num + 1); \
                       printf("%d\n", num + 2); \
                   } \
                   while (0)

void func_multiple_line()
{
    if (1)
        FUNC3(1);
    else
        ;
}

int main()
{
    func_single_line();
    func_multiple_line();

    return 0;
}
