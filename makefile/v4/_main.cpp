#include "calc/add.hpp"
#include "calc/dec.hpp"
#include "formula/avg.hpp"
#include "formula/sum.hpp"
#include <iostream>

using namespace std;

int main()
{
    cout << "1 + 1 = " << add(1, 1) << endl;
    cout << "2 - 2 = " << dec(2, 2) << endl;

    cout << "sum(1, 2, 3) = " << sum({1, 2, 3}) << endl;
    cout << "avg(1, 2, 3) = " << avg({1, 2, 3}) << endl;

    return 0;
}
