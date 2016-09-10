#include <iostream>
#include <vector>

using namespace std;

class shit
{
public:
    enum type_t
    {
        INT,
        FLOAT,
        STR,
        BOOL,
        LIST
    };

    // without shit(int), shit(bool) must be explicit
    // otherwise a call like shit(123) will be ambiguous
    // because int can implicitly convert to both bool and double
    shit(int num) : type(INT), numi(num) { cout << "int\n"; }
    shit(bool bol) : type(BOOL), bol(bol) { cout << "bool\n"; }

    // shit(const char*) is necessary
    // because char* will implicitly convert to bool instead of string
    shit(const string& str) : type(STR), str(str) { cout << "const string&\n"; }
    shit(const char* chr) : type(STR), str(string(chr)) { cout << "const char*\n"; }

    shit(double num) : type(FLOAT), numf(num) { cout << "double\n"; } 

    shit(initializer_list<shit> shits) : type(LIST), shits(shits) { cout << "initializer_list\n"; }

    type_t       type;
    int          numi;
    double       numf;
    bool         bol;
    string       str;
    vector<shit> shits; 
};

ostream&
operator << (ostream& os, const shit& s)
{
    switch (s.type)
    {
        case shit::INT:
            os << "int: " << s.numi;
            break;
        case shit::FLOAT:
            os << "float: " << s.numf;
            break;
        case shit::STR:
            os << "str: " << s.str;
            break;
        case shit::BOOL:
            os << "bool: " << s.bol;
            break;
        case shit::LIST:
            os << "list";
            break;
        default:
            ;
    }
    return os;
}

int main()
{
    shit numi = 123;
    shit numf = 123.456;
    shit str  = "fuck";
    shit bol  = true;
    shit list = { numi, numf, str, bol };

    cout << "\n";
    cout << "123: " << numi << "\n";
    cout << "123.456: " << numf << "\n";
    cout << "fuck: " << str << "\n";
    cout << "true: " << bol << "\n";
    cout << "list: " << list << "\n";

    return 0;
};

