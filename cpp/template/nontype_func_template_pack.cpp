#include <iostream>

using namespace std;

template <int tem_num, class T>
void
show(T func_num)
{
    cout << "tem_num: " << tem_num << " func_num: " << func_num << endl;
}

template <int tem_num, int... nums, class T, class... Args>
void
show(T func_num, Args... args)
{
    show<tem_num>(func_num);
    show<nums...>(std::forward<Args>(args)...);
}

int
main()
{
    show<1>(3);
    cout << endl;
    show<1, 2>(3, 4);
    cout << endl;
    show<1, 2, 3>(4, 5, 6);

    return 0;
}
