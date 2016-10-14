#include <iostream>

using namespace std;

template<typename T>
struct traits
{
    const static bool is_basic_type;
};

template<>
struct traits<int>
{
    const static bool is_basic_type = true;
};

template<>
struct traits<string>
{
    const static bool is_basic_type = false;
};

template<typename T>
bool is_basic_type(const T& t)
{
    return traits<T>::is_basic_type;
}

int main()
{
    cout << is_basic_type(123) << endl;
    cout << is_basic_type(string("shit")) << endl;
    
    return 0;
};

