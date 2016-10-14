#include <iostream>
#include <vector>

using namespace std;

// to make your own class[X] support for(a : b) , you should implement:
//
//      begin() && end()        inside X
// or
//      begin(X&) && end(X&)    outside X
//
// and these functions should return something behaves like an iterator

// so you can use std-iterator
class Shit
{
public:
    auto begin() -> decltype(vector<int>().begin()) { return nums.begin(); }
    auto end() -> decltype(vector<int>().end()) { return nums.end(); }
    vector<int> nums = {0, 1, 2, 3};
};

// or define your own iterator[D], which should supprot
//
//      ++D
//      D1 != D2
//      *D
//
class Fuck
{
public:
    class Iter
    {
    public:
        Iter(Fuck* ptr, int idx) : ptr(ptr), idx(idx){};

        int& operator*() { return ptr->nums[idx]; }
        Iter& operator++()
        {
            idx++;
            return *this;
        }

        bool operator!=(const Iter& it)
        {
            return this->ptr != it.ptr || this->idx != it.idx;
        }

        int idx;
        int len;
        Fuck* ptr;
    };

    Iter begin() { return Iter(this, 0); }
    Iter end() { return Iter(this, nums.size()); }
    vector<int> nums = {5, 6, 7, 8};
};

int
main()
{
    Shit shit;

    for (auto num : shit)
    {
        cout << num << endl;
    }

    Fuck fuck;

    for (auto num : fuck)
    {
        cout << num << endl;
    }

    return 0;
}
