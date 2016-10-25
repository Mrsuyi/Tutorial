#include <iostream>
#include <vector>

using namespace std;

template <class Out, class In>
std::vector<Out>
get(const std::vector<In>&)
{
    return std::vector<Out>(10);
}

int
main()
{
    vector<double> input = {1, 2, 3};

    vector<int> shit = get<int>(input);

    return 0;
};
