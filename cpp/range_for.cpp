#include <iostream>
#include <vector>

using namespace std;

class Shit
{
public:
    auto begin() -> decltype(vector<int>().begin())
    {
        return nums.begin();
    }
    auto end()   -> decltype(vector<int>().end())
    {
        return nums.end();
    }
    
    vector<int> nums = {0, 1, 2, 3};
};

int main()
{
    Shit shit;

    for (auto num : shit)
    {
        cout << num << endl;
    }

    return 0;
}
