#include <iostream>
#include <cstdlib>
#include <vector>

using namespace std;

int main()
{
    int* ptr = (int*)malloc(sizeof(int));

    new(ptr) int(4);

    cout << *ptr << endl;

    delete ptr;

    return 0;
};

