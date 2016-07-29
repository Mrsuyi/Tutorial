#include <iostream>
#include <unordered_map>

using namespace std;

template
<
    template <typename, typename> class C,
    typename K,
    typename V
>
class wrapper
{
    public:
    C<K, V> c;
};

template <typename K, typename V>
using umap = unordered_map<K, V>;

int main()
{
    wrapper<umap, int, int> w;

    w.c[0] = 1;
    w.c[1] = 2;

    for (auto& p : w.c)
    {
        cout << p.first << " " << p.second << endl;
    }

    return 0;
}
