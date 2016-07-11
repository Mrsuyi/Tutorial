#include <iostream>
#include <functional>

// compare-based container
#include <map>
#include <set>

// hash-based container
#include <unordered_map>
#include <unordered_set>

class Shit
{
public:
    Shit(int a, int b) : a(a), b(b) {}

    // for hash-based container
    bool operator == (const Shit& shit) const
    {
        return this->a == shit.a && this->b == shit.b;
    }

    // for compare-based container
    bool operator < (const Shit& shit) const
    {
        return this->a <= shit.a && this->b <= shit.b;
    }

    int a, b;
};

// for hash-based container
namespace std {

template<>
struct hash<Shit>
{
    size_t operator () (const Shit& shit) const
    {
        return hash<int>()(shit.a) ^ hash<int>()(shit.b);
    }
};

}

// test
int main()
{
    using namespace std;

    Shit m(1, 1), n(1, 2);

    unordered_map<Shit, string> umap;

    umap[m] = "this is m";
    umap[n] = "this is n";

    cout << "m : " << umap[m] << endl;
    cout << "n : " << umap[n] << endl;
    
    return 0;
}
