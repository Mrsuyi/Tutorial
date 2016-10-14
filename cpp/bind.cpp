#include <iostream>
#include <functional>

using namespace std;
using namespace std::placeholders;

using binary_func       = int(int, int);
using binary_func_ptr   = binary_func*;
using binary_func_class = function<binary_func>;

int add(int a, int b)
{
    return a + b;
}

int exec(int a, int b, binary_func func) // this won't accpet a funtion<> as param
{
    return func(a, b);
}

int exec2(int a, int b, binary_func_ptr func) // neither does this
{
    return func(a, b);
}

int exec3(int a, int b, binary_func_class func)
{
    return func(a, b);
}

int main()
{
    string str = "shit";

    auto lambda = [](int a, int b, string& str)
    {
        cout << str << endl;
        return add(a, b);
    };

    cout << exec(1, 1, add) << endl;
    cout << exec2(1, 1, add) << endl;
    cout << exec3(1, 1, bind(lambda, _1, _2, str)) << endl;

    return 0;
};

