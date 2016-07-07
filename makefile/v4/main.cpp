#include "calc/add.hpp"
#include "calc/dec.hpp"
#include <iostream>

using namespace std;

int main()
{
    cout << "1 + 1 = " << add(1, 1) << endl;
    cout << "2 - 2 = " << dec(2, 2) << endl;

    return 0;
}
