#include <iostream>
#include <memory>
#include <vector>

using namespace std;

class var
{
    struct base
    {
        virtual ~base() {}

        virtual void fuck() = 0;
    };

    template <class T>
    struct inherit : base
    {
        inherit(const T& t) : t(t) {}
        ~inherit() {}

        virtual void fuck() override { t.fuck(); }
        T t;
    };

public:
    template <class T>
    var(const T& t) : ptr_(new inherit<T>(t))
    {
    }

    void fuck() { ptr_->fuck(); }
private:
    unique_ptr<base> ptr_;
};

struct a
{
    void fuck() { cout << "fuck a !!!\n"; }
};

struct b
{
    void fuck() { cout << "fuck b !!!\n"; }
};

int
main()
{
    vector<var> v;

    v.push_back(var(a()));
    v.push_back(var(b()));

    for (auto& ele : v) ele.fuck();

    return 0;
};
