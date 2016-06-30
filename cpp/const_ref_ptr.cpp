#include <iostream>

using namespace std;

// anything with a 'const' modifier must:
//      + be assigned on defination (a.k.a "initialized")
//      + never be assigned again
// 
// 'const' does not ensure the value of your var is constant
// 'const' only ensures your behaviour around the var is constant
int main(int argc, char* argv[])
{
    return 0;
}

void normal()
{
    int  a = 1;
    int& b = a;
    int* c = &a;

    const int i = 1;
    const int& j = i;
    const int* k = &i;

    const int& l = 12345;
}

// const TYPE& varname
void const_ref()
{
    const int  a = 1;
    int&       b = a;  // non-const ref bind to const
    const int& c = a;  // ok

    int&       m = 12345;  // non-const ref can't bind to rvalue
    const int& n = 12345;  // ok
}

// const TYPE* varname
void const_ptr()
{
    int        a = 1;
    const int *b = &a; 
              *b = 3;  // [*b] is const, can't reassign
}

// TYPE* const varname
void ptr_const()
{
    int        a = 1;
    int* const b = &a;
    int        c = 2;
               b = &c;  // [b] is const, can't rebind
}
