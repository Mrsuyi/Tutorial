#include <iostream>

using namespace std;

class c1
{
};

class c2 : public c1
{
};

class c3: public c2
{
};

template <class C>
void func(C, c1)
{
    cout << "c1\n";
}

template <class C>
void func(C, c3)
{
    cout << "c3\n";
}

int main()
{
    func(1, c1());
    func(1, c2());
    func(1, c3());

    return 0;
};

