#include <iostream>

using namespace std;

class parent
{
public:
    void print() { cout << "shit" << endl; }
    void print(int a) { cout << a << endl; }

    virtual void show() { cout << "shit" << endl; }
    virtual void show(int a) { cout << a << endl; }
};

class child : public parent
{
public:
    using parent::print; // without this, child().print(123) is illegal

    void print() { cout << "fuck" << endl; } // this will 

    void show() override { cout << "fuck" << endl; }
};

int main()
{
    child().print(123);

    child().parent::print(123);

    return 0;
};
