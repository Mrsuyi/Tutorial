// variable


// functions


// class

class A
{
public:
    void func() {} // ok, implicitly inline
};

class B 
{
public:
    void func();
};
inline void B::func() {} // ok, explicitly inline

class C
{
public:
    void func();
};
void C::func() {} // aha, "multiple-definition" error while compiling
