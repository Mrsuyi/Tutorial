#include <iostream>
#include "config.h"

#ifdef USE_CALC
    #include "calc/calc.hpp"
#endif

using namespace std;

int main(int argc, char* argv[])
{

#ifdef USE_CALC
    cout << "use libcalc" << endl;
    cout << "1 + 1 = " << add(1, 1) << endl;
#else
    cout << "use nothing" << endl;
    cout << "1 + 1 = " << 1 + 1 << endl;
#endif

    return 0;
}
