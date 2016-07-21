#include <typeinfo>
#include <iostream>
#include <vector>

using namespace std;

template <typename T>
class wrapper
{
    public:

    using type = decltype(T().val);
    using type2 = decltype(T().vec);
    using type3 = decltype(T().vec.begin());

    wrapper(T& t) : t(t) {}
    T& t;
};

class shit
{
    public:

    int val;
    vector<int> vec;
};

int main(int argc, char* argv[])
{
    cout << (typeid(wrapper<const shit>::type) == typeid(wrapper<shit>::type)) << endl;
    cout << (typeid(wrapper<const shit>::type2) == typeid(wrapper<shit>::type2)) << endl;
    cout << (typeid(wrapper<const shit>::type3) == typeid(wrapper<shit>::type3)) << endl;

    return 0;
} 
