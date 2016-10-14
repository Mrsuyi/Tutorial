#include <iostream>
#include <future>
#include <functional>

using namespace std;

void print(future<int>& fut)
{
    cout << fut.get() << endl;
}

int main()
{
    promise<int> prom;

    future<int> futr = prom.get_future();

    thread t(print, ref(futr));

    this_thread::sleep_for(chrono::milliseconds(2000));

    prom.set_value(123);

    t.join();

    return 0;
};

