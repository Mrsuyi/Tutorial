#include <iostream>
#include <functional>
#include <typeinfo>

using namespace std;

void func() {}

auto lambda = [] { return; };

function<void()> func_class;

int main()
{
    cout << "func: " << typeid(func).name() << endl;
    cout << "lambda: " << typeid(lambda).name() << endl;
    cout << "func_class: " << typeid(func_class).name() << endl;

    cout << "func == lambda ? " << (typeid(func) == typeid(lambda)) << endl;
    cout << "func == func_class ? " << (typeid(func) == typeid(func_class)) << endl;
    cout << "lambda == func_class ? " << (typeid(lambda) == typeid(func_class)) << endl;

    return 0;
};
