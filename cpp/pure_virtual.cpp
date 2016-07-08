#include "iostream"

using namespace std;

// base
class Base
{
public:
   Base() {}

   virtual ~Base() = 0;

   virtual void print() = 0;
};

// destructor must be defined, even if it is pure virtual
Base::~Base() {} 

// normal pure-virtual function does not require a definition
// but you can define it anyway
void Base::print() 
{
    cout << "fuck" << endl;
}


// inherit
class Inherit : public Base
{
public:
    Inherit() : Base() {}
    ~Inherit() override {}

    void print() override
    {
        cout << "shit" << endl;
    }
};

int main()
{
    Inherit i;

    return 0;
}
