#include <semaphore.h>

#include <iostream>
#include <thread>

using namespace std;

sem_t sem;
int   num;

void show()
{
    do
    {
        sem_wait(&sem);
        cout << num << endl;
    }
    while (num != 0);

    cout << "exit\n";
}

int main()
{
    sem_init(&sem, 0, 0);

    thread t(show);

    while (cin >> num)
    {
        sem_post(&sem);
    }

    t.join();

    sem_destroy(&sem);

    return 0;
};

