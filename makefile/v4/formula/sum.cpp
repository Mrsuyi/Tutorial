#include "sum.hpp"
#include <vector>

using namespace std;

int sum(const vector<int>& nums)
{
    int ret = 0;
    for (int num : nums)
    {
        ret += num;
    }
    return ret;
}
