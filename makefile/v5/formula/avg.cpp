#include "avg.hpp"
#include "sum.hpp"
#include <vector>

using namespace std;

int avg(const vector<int>& nums)
{
    return sum(nums) / nums.size();
}
