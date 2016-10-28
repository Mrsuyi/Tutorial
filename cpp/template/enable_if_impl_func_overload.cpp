#include <iostream>
#include <type_traits>
#include <unordered_map>

using namespace std;

class shit
{
public:
    static const bool is_shit = true;
};

class fuck
{
public:
    static const bool is_shit = false;
};

template <class T>
void func(T, typename enable_if<T::is_shit>::type* = 0)
{
    cout << "shit!\n";
}

template <class T>
void func(T, typename enable_if<!T::is_shit>::type* = 0)
{
    cout << "fuck!\n";
}

int main()
{
    func(shit());
    func(fuck());

    return 0;
};

