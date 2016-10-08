#include <iostream>
#include <type_traits>

using namespace std;

template<typename Func, typename... Args>
typename result_of<Func(Args...)>::type
exec(Func func, Args&&... args)
{
    return func(forward<Args>(args)...);
}

int add(int a, int b)
{
    return a + b;
}

void show()
{
    cout << "shit\n";
}

int main()
{
    cout << exec(add, 10, 10); 

    exec(show);

    return 0;
};

