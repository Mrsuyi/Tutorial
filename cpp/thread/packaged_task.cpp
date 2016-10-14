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
    packaged_task<int(int, int)> task(add);

    future<int> res = task.get_future();

    thread(move(task), 1, 1).detach();

    cout << res.get() << endl;

    return 0;
};

