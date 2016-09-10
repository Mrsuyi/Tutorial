#include <iostream>
#include <vector>

using namespace std;

class shit
{
public:
    //shit() : num(123)
    //{
        //cout << "constructor of nothing\n";
    //}

    shit(int num) : num(num)
    {
        cout << "constructor of int\n";
    }

    shit(initializer_list<shit> shits) : shits(shits)
    {
        cout << "constructor of shits\n";
    }

    shit operator = (int num)
    {
        cout << "operator of int\n";
        return shit(num);
    } 

    shit operator = (initializer_list<shit> shits)
    {
        cout << "operator of list\n";
        return shit(shits);
    }

    int num;
    vector<shit> shits;
};

int main()
{
    shit a(123);
    shit b = 456;
    shit c({});

    // without shit() defined, these will call this initializer_list constructor
    shit d = {};
    shit e{};

    return 0;
};
