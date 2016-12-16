#include <typeinfo>
#include <iostream>
#include <vector>

using namespace std;

struct shit
{
    int show() { return 1; }
};

decltype(declval<shit>().show()) fuck()
{
    return 2;
}

int main()
{
    size_t sz;
    
    cout << fuck() << endl;

    return 0;
} 
