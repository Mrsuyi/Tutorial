#include <iostream>

using namespace std;

template<typename T>
class Outer
{
public:
    class Inner;
};

template<typename T>
class Outer<T>::Inner
{
public:
    void show()
    {
        cout << "shit\n";
    }
};

int main()
{
    Outer<int>::Inner i;

    i.show();

    return 0;
};

