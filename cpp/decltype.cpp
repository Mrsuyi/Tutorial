#include <typeinfo>
#include <iostream>
#include <vector>

using namespace std;

// global
vector<int> vec;
const vector<int> cvec;

using t = decltype(vec);
using ct = decltype(cvec);

using c_t = const t;
using c_ct = const ct;

using v_it_t = decltype(vec.begin());
using v_cit_t = decltype(vec.cbegin());
using cv_it_t = decltype(cvec.begin());
using cv_cit_t = decltype(cvec.cbegin());

// within class
template
<
    template <typename> class C,
    typename V
>
class wrapper
{
    public:
    C<V> container;
};

class shit
{
    public:
    int val;
    vector<int> vec;
};

int main(int argc, char* argv[])
{
    cout << typeid(t).name() << endl;
    cout << typeid(ct).name() << endl;
    cout << typeid(c_t).name() << endl;
    cout << typeid(c_ct).name() << endl;
    
    cout << typeid(v_it_t).name() << endl;
    cout << typeid(v_cit_t).name() << endl;
    cout << typeid(cv_it_t).name() << endl;
    cout << typeid(cv_cit_t).name() << endl;

    /*
    cout << (typeid(wrapper<const shit>::type) == typeid(wrapper<shit>::type)) << endl;
    cout << (typeid(wrapper<const shit>::type2) == typeid(wrapper<shit>::type2)) << endl;
    cout << (typeid(wrapper<const shit>::type3) == typeid(wrapper<shit>::type3)) << endl;
    */

    return 0;
} 
