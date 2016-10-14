#include <iostream>
#include <future>

using namespace std;

int add(int a, int b)
{
    this_thread::sleep_for(chrono::milliseconds(1000));
    return a + b;
}

int main()
{
    auto policy = launch::async | launch::deferred;

    future<int> res = async(policy, add, 1, 1);

    cout << res.get() << endl;

    return 0;
};

