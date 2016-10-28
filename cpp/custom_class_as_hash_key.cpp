#include <cmath>
#include <iostream>
#include <unordered_map>

using namespace std;

struct shit
{
    bool operator==(const shit& s) const { return val == s.val; }
    int val;
};

namespace std
{
template <>
struct hash<shit>
{
    size_t operator()(const shit& s) const { return hash<int>()(s.val); }
};
}

int
main()
{
    unordered_map<shit, int> a;

    a[shit()] = 1;

    return 0;
};
