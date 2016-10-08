#include <iostream>

using namespace std;

int main()
{
    cin.exceptions(ios::failbit | ios::badbit | ios::eofbit);

    try
    {
        int a;
        cin >> a;
        cout << a << endl;
    }
    catch (exception e)
    {
        cout << e.what() << endl;
    }

    return 0;
};

