#include <iostream>

using namespace std;

class shit
{
public:
    int    vali;
    double valf;
    string vals;

    template<typename T>
    T get() const;

    template<typename T>
    void set(const T&);

    template<typename T>
    shit& operator () (const T&);
};

template<>
int
shit::get<int>() const
{
    return vali;
}

template<>
double
shit::get<double>() const
{
    return valf;
}

template<>
string
shit::get<string>() const
{
    return vals;
}

template<>
void
shit::set(const int& i)
{
    vali = i;
}

template<>
void
shit::set(const double& f)
{
    valf = f;
}

template<>
void
shit::set(const string& s)
{
    vals = s;
}

template<>
shit&
shit::operator () (const int& i)
{
    this->set(i);
    return *this;
}

template<>
shit&
shit::operator () (const double& i)
{
    this->set(i);
    return *this;
}

template<>
shit&
shit::operator () (const string& s)
{
    this->set(s);
    return *this;
}

int main(int argc, char* argv[])
{
    cout << shit()(1)("asdf")(234.23).get<string>();

    return 0;
};

