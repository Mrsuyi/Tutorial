#include <iostream>

using namespace std;

class shit
{
public:
    shit()
    {
        val_ = 0;
        cout << "construct shit default" << endl;
    }
    shit(const shit&)
    {
        val_ = 1;
        cout << "construct shit const&" << endl;
    }
    shit(shit&&)
    {
        val_ = 2;
        cout << "construct shit &&" << endl;
    }
    ~shit()
    {
        val_ = 0;
        cout << "destruct shit" << endl;
    }
private:
    int val_;
};

class container
{
public:
    //container(shit&& shit) : shit_(shit) {}
    container(shit&& shit) : shit_(move(shit)) {}
    container(const shit& shit) : shit_(shit) {}

private:
    shit shit_;
};

int main()
{
    shit s;
    container c(s);
    container c2(move(s));

    return 0;
}
