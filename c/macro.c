#include "stdio.h"

//========== define | ifdef | ifndef | if | else | endif ==========//
#define NUM 100
#ifdef NUM
    #undef  NUM
    #define NUM 200
#else
    #define NUM 100
#endif

#if NUM > 100
    #undef NUM
    #define NUM 300
#endif

void define()
{
    printf("%d\n", NUM);
    printf("NUM\n");
}

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

//==================== function va_args ====================//
#define VA_ARGS1(vars...)    printf(vars)
#define VA_ARGS2(first, ...) printf(first, __VA_ARGS__)  // this cannot handle empty args
#define VA_ARGS3(first, ...) printf(first, ##__VA_ARGS__)

void func_va_args()
{
    VA_ARGS1("%d\n%d\n", 100, 200);
    //VA_ARGS2("empty");
    VA_ARGS3("%d\n%d\n", 300, 400);
}

//========================= magic vars =========================//
void magic_vars()
{
    printf("__FILE__ : %s\n", __FILE__);
    printf("__LINE__ : %d\n", __LINE__);
    printf("__func__ : %s\n", __func__);
    printf("__FUNCTION__ : %s\n", __FUNCTION__);
    printf("__PRETTY_FUNCTION__ : %s\n", __PRETTY_FUNCTION__);

    printf("__COUNTER__ : %d\n", __COUNTER__);
    printf("__COUNTER__ : %d\n", __COUNTER__);
    printf("__COUNTER__ : %d\n", __COUNTER__);
}

//============================== string ==============================//
#define STR(x)    #x
#define STR_(x)   STR(x)
#define CAT(x, y) STR(x##y)

#define ONE_EXPANSION STR(__LINE__)
#define TWO_EXPANSION STR_(__LINE__)

void str()
{
    printf("a simple string: %s\n", STR(a simple string));
    printf("two word: %s\n", CAT(two, word));
    printf("expand __LINE__ once will produce %s\n", ONE_EXPANSION);
    printf("expand __LINE__ twice will produce %s\n", TWO_EXPANSION);
}

int main()
{
    define();
    func_single_line();
    func_multiple_line();
    func_va_args();
    str();
    magic_vars();

    return 0;
}
