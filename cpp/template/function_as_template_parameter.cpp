#include <functional>
#include <iostream>

using namespace std;

using func = int (*)(int, int);
using funct = function<int(int, int)>;

template <func f>
int
exec(int a, int b)
{
    return f(a, b);
}

int
add(int a, int b)
{
    return a + b;
}

int
main()
{
    cout << exec<add>(1, 2) << endl;

    return 0;
};
