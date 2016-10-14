#include <iostream>

using namespace std;

struct Printer
{
    Printer(const string& str = "shit") : name(str)
    {
        cout << name << " construct\n";
    }

    ~Printer()
    {
        cout << name << " desctruct\n";
    }

    string name;
};

struct Parent
{
    Parent() : parent_member("parent_member")
    {
        cout << "parent construct\n";
    }
    virtual ~Parent()
    {
        cout << "parent destruct\n";
    }

    Printer parent_member;
};

struct Child : public Parent
{
    Child() : child_member("child_member")
    {
        cout << "child construct\n";
    }
    virtual ~Child() override
    {
        cout << "child destruct\n";
    }

    Printer child_member;
};

int main()
{
    Child child;

    return 0;
};

