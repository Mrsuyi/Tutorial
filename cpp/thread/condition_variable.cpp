#include <iostream>
#include <thread>
#include <condition_variable>

using namespace std;

mutex mt;
condition_variable cv;
bool emitted = false;

void work(int i)
{
    unique_lock<mutex> lk(mt);
    cv.wait(lk, [&](){ return emitted; });
    cout << i << " is done\n";
}

int main()
{
    thread ts[10];

    for (size_t i = 0; i < 10; ++i)
    {
        ts[i] = thread(work, i);
    }

    {
        unique_lock<mutex> lk(mt);
        emitted = true;
        cv.notify_all();
    }

    for (auto& t : ts)
    {
        t.join();
    }

    return 0;
};

