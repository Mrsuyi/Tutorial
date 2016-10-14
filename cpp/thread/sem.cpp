#include <iostream>
#include <condition_variable>
#include <thread>

using namespace std;

class Sem
{
public:
    Sem() : val_(0) {}

    void post()
    {
        unique_lock<mutex> lk(mtx_);
        if (++val_ <= 0)
        {
            cv_.notify_one();
        }
    }

    void wait()
    {
        unique_lock<mutex> lk(mtx_);
        if (--val_ < 0)
        {
            cv_.wait(lk);
        }
    }

private:
    int val_;
    mutex mtx_;
    condition_variable cv_;
};

Sem sem;

void work()
{
    while (true)
    {
        sem.wait();
        cout << "shit\n";
    }
}

int main()
{
    thread ts[10];
    for (auto& t : ts)
    {
        t = thread(work);
    }

    size_t num;
    while (cin >> num)
    {
        for (size_t i = 0; i < num; ++i)
        {
            sem.post();
        }
    }

    for (auto& t : ts)
    {
        t.join();
    }

    return 0;
};

